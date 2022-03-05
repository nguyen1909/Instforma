//
//  Form.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 23/02/2022.
//

import Foundation
import UIKit

public class Form {
    
    var inputs: [UITextField]
    var theme: Theme!
    var isNFC: Bool
    
    init(theme: Theme, inputs: [UITextField] ,isNFC: Bool){
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
        
        if(self.inputs.isEmpty){
            let emailTextField = UITextField()
            let passwordTextField = UITextField()
            
            self.inputs.append(emailTextField)
            self.inputs.append(passwordTextField)
        }
        
        for input in inputs {
            targetView.addSubview(input)
        }
        let buttonSignin = UIButton()
        targetView.addSubview(buttonSignin)
    }
    
    private func applyThemeToInput(inputs: [UITextField]){
        
        for input in inputs {
            //Tout les parametres d'un input
            input.textColor = self.theme.textColor
            input.backgroundColor = self.theme.backgroundColor
            input.frame.size.width = CGFloat(self.theme.inputWidth)
            input.frame.size.height = CGFloat(self.theme.inputHeight)
            
        }
        
    }
    
    private func buildSingUp(targetView: UIView){
        if(self.inputs.isEmpty){
            let nameTextField = UITextField()
            let emailTextField = UITextField()
            let passwordTextField = UITextField()
            let gender = UITextField()
            
            self.inputs.append(nameTextField)
            self.inputs.append(emailTextField)
            self.inputs.append(passwordTextField)
            self.inputs.append(gender)
        }
        
        for input in inputs {
            targetView.addSubview(input)
        }
        
        let buttonSignup = UIButton()
        buttonSignup.backgroundColor = self.theme.backgroundColor
        buttonSignup.frame.size.width = CGFloat(self.theme.inputWidth)
        buttonSignup.frame.size.height = CGFloat(self.theme.inputHeight)
        buttonSignup.titleLabel?.textColor = self.theme.textColor
        //buttonSignup.layer.borderColor = CGColor(self.theme.baseColor)
        buttonSignup.layer.cornerRadius = CGFloat(self.theme.inputRadius)
        //buttonSignup.layoutMargins = UIEdgeInsets(self.theme.inputMargin)

        targetView.addSubview(buttonSignup)
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
