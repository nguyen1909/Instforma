//
//  ErrorUtils.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 26/02/2022.
//

import Foundation

class ErrorUtils {
    
    enum Code: Int {
        case invalidIdentifier = 1
        case fileAlreadyExists
        case fileNotFound
        case invalidFileInfo
    }
    
    private static var errors = ErrorUtils.generateErrors()
    
    private class func generateErrors() -> [Code: String] {
        return [
            Code.invalidIdentifier: "Please check your identifier",
            Code.fileAlreadyExists: "File exists at path, you must specified the override option",
            Code.fileNotFound: "File not found with the given identifier",
            Code.invalidFileInfo: "File info is corrupted"
        ]
    }

    public class func buildError(code: Code) -> Error {
        return NSError(domain: "com.esgi.appstorage", code: code.rawValue, userInfo: [
            NSLocalizedDescriptionKey: self.errors[code] ?? ""
        ])
    }
    
}


