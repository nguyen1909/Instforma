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
    
    var username: UITextField?
    var emailTextField: UITextField?
    var passwordTextField: UITextField?
    var dateBirthday: UITextField?
    var buttonSignup: UIButton?
    var theme: Theme!
    var isNFC: Bool?
    
    init(theme: Theme, isNFC: Bool){
        self.theme = theme
        self.isNFC = isNFC
    }
    
    // Créer une fonction "build" qui prend en paramètre une scroll view ou une view et qui va contenir tout les champs
    
    
    
    
}
