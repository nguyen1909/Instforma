//
//  Form.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 23/02/2022.
//

import Foundation
import UIKit

public class Form {
    
    /*var formType : ITypeForm
    var theme : Theme
    var nfc : NFC?
    
    init(formType : ITypeForm, theme: Theme, isNFC : Bool) {
        self.formType = formType
        self.theme = theme
        if isNFC {
            self.nfc = NFC()
        }
    }*/
    
    var inputs: [UITextField]?
    var theme: Theme!
    var isNFC: Bool?
    
    init(theme: Theme, inputs: [UITextField], isNFC: Bool){
        self.inputs = inputs
        self.theme = theme
        self.isNFC = isNFC
    }
    
    init(theme: Theme, isNFC: Bool){
        self.inputs = []
        self.theme = theme
        self.isNFC = isNFC
    }
    
    init(theme: Theme){
        self.inputs = []
        self.theme = theme
        self.isNFC = false
    }
    
    func build(view: UIView?){
        
        
        
    }
    
}
