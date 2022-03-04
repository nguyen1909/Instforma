//
//  SingIn.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 23/02/2022.
//

import Foundation
import UIKit

public class SignIn : ITypeForm{
    //contient les champs :
    //faut qu'il soit scrollable ? car si la view en params en trop petite bah ca sera moche
    //UIinput x fois
    //UIButton
    //NFC Button (hidden as default)

    var emailTextField: UITextField
    var passwordTextField: UITextField
    var buttonSignin: UIButton
    var description: String{
        return "Signin{\(self.emailTextField),\(self.passwordTextField),\(self.buttonSignin)}"
    }
    
    init(emailTextField: UITextField, passwordTextField: UITextField, buttonSignin: UIButton){
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        self.buttonSignin = buttonSignin
    }
    
}
