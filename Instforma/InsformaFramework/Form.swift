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

    
    func build(signInFormTargetView: UIView){
        if(!checkView(targetView: signInFormTargetView)){
            print(ErrorUtils.buildError(code: .viewIsTooSmall))
        }
        buildSingIn(targetView: signInFormTargetView)
    }
    
    func build(signUpFormTargetView: UIView){
        if(!checkView(targetView: signUpFormTargetView)){
            print(ErrorUtils.buildError(code: .viewIsTooSmall))
        }
        buildSingUp(targetView: signUpFormTargetView)
    }
    
    private func buildSingIn(targetView: UIView){
        if(self.inputs.count > 0){
            for input in inputs {
                //Tout les parametres d'un input
                input.textColor = self.theme.textColor
                input.backgroundColor = self.theme.backgroundColor
                input.frame.size.width = CGFloat(self.theme.inputWidth)
                input.frame.size.height = CGFloat(self.theme.inputHeight)
                
                targetView.addSubview(input)
            }
        }
    }
    
    private func buildSingUp(targetView: UIView){
        if(self.inputs.count > 0){
            for input in inputs {
                //Tout les parametres d'un input
                input.textColor = self.theme.textColor
                input.backgroundColor = self.theme.backgroundColor
                input.frame.size.width = CGFloat(self.theme.inputWidth)
                input.frame.size.height = CGFloat(self.theme.inputHeight)
                
                targetView.addSubview(input)
            }
        }
    }
    
    func checkView(targetView : UIView) -> Bool{
        let widthToTest = theme.inputWidth
        let heightToTest = Float(400.0)
        let marginToTest = theme.inputMargin as Float
        let minWidth = widthToTest + 2.00 * marginToTest
        let minHeight = heightToTest + 2.00 * marginToTest
        let viewWidth = Float(targetView.bounds.size.width)
        let viewHeight = Float(targetView.bounds.size.height)
        if (viewWidth < minWidth && viewHeight < minHeight) {
            return true
        }
        else {
            return false
        }
    }
    
}
