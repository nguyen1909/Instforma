//
//  IFileRepository.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 26/02/2022.
//

import Foundation


struct ThemesFile {
    let identifier: String
    var data: Data? = nil
    var expirationDate: Date? = nil
    var createdDate: Date? = nil
    var lastUpdatedDate: Date? = nil
}

struct FileRepositorySaveOptions {
    let override: Bool?
}

protocol IFileRepository {
    func save(themeFile: ThemesFile, options: FileRepositorySaveOptions?, completion: (Error?) -> Void)
    func get(identifier: String, completion: (Error?, ThemesFile?) -> Void)
    func delete(identifier: String, completion: (Error?) -> Void)
    func getAll(completion: (Error?, [ThemesFile]?) -> Void)
    func clear(completion: (Error?) -> Void)
}


protocol IAppStorageDependencyModule {
    var fileRepository: IFileRepository { get }
}

class ProdAppStorageDependencyModule: IAppStorageDependencyModule {
    
    var fileRepository: IFileRepository {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentURL = urls[0]
        let filesBaseURL = documentURL.appendingPathComponent("@files")
        return LocalFileRepository(baseURL: filesBaseURL)
    }
    
    
    
}

