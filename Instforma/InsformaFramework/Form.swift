//
//  Form.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 23/02/2022.
//

import Foundation
import UIKit

public class Form {
    
    //Déclarer un tableau d'input par default
    //var defaultInputs: [UITextField] = [emailTextField, passwordTextField]
    var defaultInputs: [UITextField] = []
    var inputs: [UITextField]
    var theme: Theme!
    var isNFC: Bool
    
    init(theme: Theme, inputs: [UITextField], isNFC: Bool){
        self.inputs = inputs
        self.theme = theme
        self.isNFC = isNFC
    }
    
    init(theme: Theme, isNFC: Bool){
        self.inputs = self.defaultInputs
        self.theme = theme
        self.isNFC = isNFC
    }
    
    init(theme: Theme){
        self.inputs = self.defaultInputs
        self.theme = theme
        self.isNFC = false
    }
    
    func build(targetView: UIView?){
        
        if(self.inputs.count > 0){
            for input in inputs {
                //Tout les parametres d'un input
                input.textColor = self.theme.textColor
                input.backgroundColor = self.theme.backgroundColor
                input.frame.size.width = CGFloat(self.theme.inputWidth)
                input.frame.size.height = CGFloat(self.theme.inputHeight)
                
                targetView?.addSubview(input)
            }
        }
        
    }
    
}
