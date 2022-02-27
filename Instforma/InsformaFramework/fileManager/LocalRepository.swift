//
//  LocalJSONRepository.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 26/02/2022.
//

import Foundation
import CryptoKit
import FileProvider


fileprivate class LocalFileInfo {
    let identifier: String
    var createdDate: Date
    var lastUpdatedDate: Date
    var expirationDate: Date?
    
    init(identifier: String, createdDate: Date, lastUpdatedDate: Date, expirationDate: Date? = nil) {
        self.identifier = identifier
        self.createdDate = createdDate
        self.lastUpdatedDate = lastUpdatedDate
        self.expirationDate = expirationDate
    }
    
    class func fromDictionary(_ dict: [String: Any]) -> LocalFileInfo? {
        guard let identifier = dict["identifier"] as? String,
              let createdDateString = dict["createdDate"] as? String,
              let lastUpdatedDateString = dict["lastUpdatedDate"] as? String else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZ"
        guard let createdDate = dateFormatter.date(from: createdDateString),
              let lastUpdatedDate = dateFormatter.date(from: lastUpdatedDateString) else {
            return nil
        }
        var expirationDate: Date?
        if let expirationDateString = dict["expirationDate"] as? String {
            expirationDate = dateFormatter.date(from: expirationDateString)
        }
        return LocalFileInfo(identifier: identifier,
                             createdDate: createdDate,
                             lastUpdatedDate: lastUpdatedDate,
                             expirationDate: expirationDate)
    }
    
    func toDictionary() -> [String: Any] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZ"
        var expirationDateString: String = ""
        if let ed = self.expirationDate {
            expirationDateString = dateFormatter.string(from: ed)
        }
        return [
            "identifier": self.identifier,
            "createdDate": dateFormatter.string(from: self.createdDate),
            "lastUpdatedDate": dateFormatter.string(from: self.lastUpdatedDate),
            "expirationDate": expirationDateString,
        ]
    }
}

fileprivate extension Array where Element == LocalFileInfo {
    func findIndex(identifier: String) -> Int? {
        return self.firstIndex { lfi in
            return lfi.identifier == identifier
        }
    }
    func find(idenfifier: String) -> LocalFileInfo? {
        guard let idx = self.findIndex(identifier: idenfifier) else {
            return nil
        }
        return self[idx]
    }
}


class LocalFileRepository: IFileRepository {
    
    let baseURL: URL
    fileprivate var fileInfos: [LocalFileInfo]
    
    init(baseURL: URL) {
        self.baseURL = baseURL
        self.fileInfos = []
        self.loadFileInfos()
        if !self.fileExists(at: self.baseURL, isDirectory: true) {
            self.mkdir(at: self.baseURL)
        }
    }
    
    fileprivate func loadFileInfos() {
        do {
            let data = try Data(contentsOf: self.baseURL.appendingPathComponent(".fileInfos.json"))
            let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            guard let arr = json as? [[String: Any]] else {
                self.fileInfos = []
                return
            }
            self.fileInfos = arr.compactMap { dict in
                return LocalFileInfo.fromDictionary(dict)
            }
        } catch {
            self.fileInfos = []
        }
    }
    
    @discardableResult
    fileprivate func writeFileInfos() -> Bool {
        do {
            let fileInfoDictionaries = self.fileInfos.map { lfi in
                return lfi.toDictionary()
            }
            let jsonData = try JSONSerialization.data(withJSONObject: fileInfoDictionaries, options: .fragmentsAllowed)
            try jsonData.write(to: self.baseURL.appendingPathComponent(".fileInfos.json"))
            return true
        } catch {
            return false
        }
    }
    
    func fileExists(at url: URL, isDirectory: Bool) -> Bool {
        var b = ObjCBool(isDirectory)
        return FileManager.default.fileExists(atPath: url.path, isDirectory: &b)
    }
    
    @discardableResult
    func mkdir(at url: URL) -> Bool {
        return (try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)) != nil
    }
    
    func save(theme: ThemesFile, options: FileRepositorySaveOptions?, completion: (Error?) -> Void) {
        guard let fn = self.identifierToFileName(theme.identifier) else {
            completion(ErrorUtils.buildError(code: .invalidIdentifier))
            return
        }
        let fileURL = self.baseURL.appendingPathComponent(fn)
        if self.fileExists(at: fileURL, isDirectory: false) {
            guard options?.override == true else {
                completion(ErrorUtils.buildError(code: .fileAlreadyExists))
                return
            }
        }
        do {
            try theme.data?.write(to: fileURL)
            let currentDate = Date()
            if let lfi = self.fileInfos.find(idenfifier: theme.identifier) {
                lfi.lastUpdatedDate = currentDate
                lfi.expirationDate = theme.expirationDate
            } else {
                self.fileInfos.append(LocalFileInfo(identifier: theme.identifier,
                                                    createdDate: currentDate,
                                                    lastUpdatedDate: currentDate,
                                                    expirationDate: theme.expirationDate))
            }
            self.writeFileInfos()
            completion(nil) // SUCCESS
        } catch {
            completion(error)
        }
    }
    
    func identifierToFileName(_ identifier: String) -> String? {
        guard let data = identifier.data(using: .utf8) else {
            return nil
        }
        let digest = SHA256.hash(data: data)
        let res = digest.map { element in
            return String(format: "%02x", element)
        }
        return res.joined()
    }
    
    func get(identifier: String, completion: (Error?, ThemesFile?) -> Void) {
        guard let fn = self.identifierToFileName(identifier) else {
            completion(ErrorUtils.buildError(code: .invalidIdentifier), nil)
            return
        }
        let fileURL = self.baseURL.appendingPathComponent(fn)
        guard self.fileExists(at: fileURL, isDirectory: false) else {
            completion(ErrorUtils.buildError(code: .fileNotFound), nil)
            return
        }
        if let lfi = self.fileInfos.find(idenfifier: identifier),
           let expirationDate = lfi.expirationDate {
            if expirationDate.compare(Date()) == .orderedAscending { // file expired
                self.delete(identifier: identifier) { err in
                    if err != nil {
                        completion(err, nil)
                    } else {
                        completion(ErrorUtils.buildError(code: .fileNotFound), nil)
                    }
                }
                return
            }
        }
        do {
            let data = try Data(contentsOf: fileURL)
            if let lfi = self.fileInfos.find(idenfifier: identifier) {
                completion(nil, ThemesFile(identifier: identifier,
                                     data: data,
                                     expirationDate: lfi.expirationDate,
                                     createdDate: lfi.createdDate,
                                     lastUpdatedDate: lfi.lastUpdatedDate))
            } else {
                completion(ErrorUtils.buildError(code: .invalidFileInfo), nil)
            }
        } catch {
            completion(error, nil)
        }
    }
    
    func delete(identifier: String, completion: (Error?) -> Void) {
        guard let fn = self.identifierToFileName(identifier) else {
            completion(ErrorUtils.buildError(code: .invalidIdentifier))
            return
        }
        let fileURL = self.baseURL.appendingPathComponent(fn)
        guard self.fileExists(at: fileURL, isDirectory: false) else {
            completion(ErrorUtils.buildError(code: .fileNotFound))
            return
        }
        do {
            try FileManager.default.removeItem(at: fileURL)
            if let idx = self.fileInfos.findIndex(identifier: identifier) {
                self.fileInfos.remove(at: idx)
                self.writeFileInfos()
            }
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func getAll(completion: (Error?, [ThemesFile]?) -> Void) {
        let fileInfos = self.fileInfos
        let fileInfosCount = fileInfos.count
        var themes: [ThemesFile] = []
        var completionCalled: Bool = false
        for fileInfo in fileInfos {
            self.get(identifier: fileInfo.identifier) { err, item in
                guard err == nil,
                      let it = item else {
                    if !completionCalled {
                        completionCalled = true
                        completion(err, nil)
                    }
                    return
                }
                themes.append(it)
                if themes.count == fileInfosCount && !completionCalled {
                    completion(nil, themes)
                }
            }
        }
    }
    
    func clear(completion: (Error?) -> Void) {
        do {
            try FileManager.default.removeItem(at: self.baseURL)
            self.mkdir(at: self.baseURL)
            self.fileInfos = []
            self.writeFileInfos()
            completion(nil)
        } catch {
            completion(error)
        }
    }

    
}
