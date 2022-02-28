//
//  SignUp.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 23/02/2022.
//

import Foundation
import UIKit

public class SignUp : ITypeForm{
    //contient les champs :
    //faut qu'il soit scrollable ? car si la view en params en trop petite bah ca sera moche
    //UIinput x fois
    //UIButton
    //NFC Button (hidden as default)
    
    var username: UITextField
    var emailTextField: UITextField
    var passwordTextField: UITextField
    var dateBirthday: UITextField
    var buttonSignup: UIButton
    var description: String{
        return "Signup{\(self.username),\(self.emailTextField),\(self.passwordTextField),\(self.dateBirthday),\(self.buttonSignup)}"
    }
    
    init(username: UITextField, emailTextField: UITextField, passwordTextField: UITextField, dateBirthday: UITextField ,buttonSignup: UIButton){
        self.username = username
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        self.dateBirthday = dateBirthday
        self.buttonSignup = buttonSignup
    }
    
}
