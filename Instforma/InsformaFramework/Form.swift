//
//  Form.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 23/02/2022.
//

import Foundation

public class Form {
    
    var formType : ITypeForm
    var theme : Theme
    var nfc : NFC?
    
    init(formType : ITypeForm, theme: Theme, isNFC : Bool) {
        self.formType = formType
        self.theme = theme
        if isNFC {
            self.nfc = NFC()
        }
    }
    
}

