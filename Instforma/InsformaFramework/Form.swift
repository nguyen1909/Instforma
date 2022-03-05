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

    var iSpacing = Float(0.0)


    
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
    
    func build(signUpFormTargetView: UIScrollView){
        if(!checkView(targetView: signUpFormTargetView)){
            print(ErrorUtils.buildError(code: .viewIsTooSmall))
        }
        buildSingUp(targetView: signUpFormTargetView)
    }
    
    private func buildSingIn(targetView: UIView){
        
        if(self.inputs.isEmpty){
            
            let emailTextField = UITextField()
            emailTextField.placeholder = "Email"

            let passwordTextField = UITextField()
            passwordTextField.placeholder = "Password"
            
            self.inputs.append(emailTextField)
            self.inputs.append(passwordTextField)
        }
    
        for input in inputs {
            targetView.addSubview(input)
        }
        applyThemeToInput(inputs: self.inputs)
        
        let buttonSignin = UIButton()
        buttonSignin.setTitle("Submit", for: UIControl.State.normal)
        buttonSignin.setTitleColor(UIColor.black, for: UIControl.State.normal)
        buttonSignin.frame = CGRect(x: CGFloat(theme.inputMargin), y: CGFloat(iSpacing), width: CGFloat(theme.inputWidth), height: CGFloat(theme.inputHeight))
        applyThemeToButton(button: buttonSignin)
        
        targetView.addSubview(buttonSignin)
    }
    
    private func applyThemeToInput(inputs: [UITextField]){
        iSpacing = theme.inputMargin

        for input in inputs {
            //Tout les parametres d'un input
            input.layer.cornerRadius = CGFloat(theme.inputRadius)
            input.frame = CGRect(x: CGFloat(theme.inputMargin), y: CGFloat(iSpacing), width: CGFloat(theme.inputWidth), height: CGFloat(theme.inputHeight))
            iSpacing = iSpacing + theme.inputHeight + theme.inputMargin
            input.frame.size.width = CGFloat(theme.inputWidth)
            input.frame.size.height = CGFloat(theme.inputHeight)
            input.setLeftPaddingPoints(CGFloat(theme.inputPadding))
            input.setRightPaddingPoints(CGFloat(theme.inputPadding))

            input.layoutMargins = UIEdgeInsets(top: CGFloat(theme.inputMargin), left: CGFloat(theme.inputMargin), bottom: CGFloat(theme.inputMargin), right: CGFloat(theme.inputMargin))
            input.textColor = theme.textColor
            input.tintColor = theme.baseColor
            input.backgroundColor = theme.backgroundColor
            
        }
        
    }
    
    private func buildSingUp(targetView: UIView){
        if(self.inputs.isEmpty){
            let nameTextField = UITextField()
            nameTextField.placeholder = "Name"
            let emailTextField = UITextField()
            emailTextField.placeholder = "Email"
            let passwordTextField = UITextField()
            passwordTextField.placeholder = "Password"
            
            self.inputs.append(nameTextField)
            self.inputs.append(emailTextField)
            self.inputs.append(passwordTextField)
        }
        
        for input in inputs {
            targetView.addSubview(input)
        }
        applyThemeToInput(inputs: self.inputs)
        
        let items = ["Male" , "Female"]
        let gender = UISegmentedControl(items : items)
        gender.layer.cornerRadius = CGFloat(theme.inputRadius)
        gender.frame = CGRect(x: CGFloat(theme.inputMargin), y: CGFloat(iSpacing), width: CGFloat(theme.inputWidth), height: CGFloat(theme.inputHeight))
        iSpacing = iSpacing + theme.inputHeight + theme.inputMargin
        gender.frame.size.width = CGFloat(theme.inputWidth)
        gender.frame.size.height = CGFloat(theme.inputHeight)

        gender.layoutMargins = UIEdgeInsets(top: CGFloat(theme.inputMargin), left: CGFloat(theme.inputMargin), bottom: CGFloat(theme.inputMargin), right: CGFloat(theme.inputMargin))
        gender.tintColor = theme.baseColor
        gender.backgroundColor = theme.backgroundColor
        
        let buttonSignup = UIButton()
        buttonSignup.setTitle("Submit", for: UIControl.State.normal)
        buttonSignup.setTitleColor(UIColor.black, for: UIControl.State.normal)
        buttonSignup.frame = CGRect(x: CGFloat(theme.inputMargin), y: CGFloat(iSpacing), width: CGFloat(theme.inputWidth), height: CGFloat(theme.inputHeight))
        applyThemeToButton(button: buttonSignup)
        
        targetView.addSubview(buttonSignup)
        targetView.addSubview(gender)
    }
    
    private func applyThemeToButton(button: UIButton){
        button.layer.cornerRadius = CGFloat(self.theme.inputRadius)
        button.layoutMargins = UIEdgeInsets(top: CGFloat(self.theme.inputMargin), left: CGFloat(self.theme.inputMargin), bottom: CGFloat(self.theme.inputMargin), right: CGFloat(self.theme.inputMargin))
        button.contentEdgeInsets = UIEdgeInsets(top: CGFloat(self.theme.inputPadding), left: CGFloat(self.theme.inputPadding), bottom: CGFloat(self.theme.inputPadding), right: CGFloat(self.theme.inputPadding))
        button.tintColor = self.theme.buttonColor
        button.backgroundColor = self.theme.backgroundColor
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

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
