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
    func save(theme: ThemesFile, options: FileRepositorySaveOptions?, completion: (Error?) -> Void)
    func get(identifier: String, completion: (Error?, ThemesFile?) -> Void)
    func delete(identifier: String, completion: (Error?) -> Void)
    func getAll(completion: (Error?, [ThemesFile]?) -> Void)
    func clear(completion: (Error?) -> Void)
}


