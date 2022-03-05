//
//  SignupViewController.swift
//  Instforma
//
//  Created by David NGUYEN on 28/02/2022.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var targetView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myTheme = Theme(name: "Basic", inputHeight: 50, inputWidth: 300, inputRadius: 5, inputPadding: 15, inputMargin: 5, textColor: UIColor.black, buttonColor: UIColor.gray, baseColor: UIColor.brown, backgroundColor: UIColor.lightGray)
                
        let myForm = Form(theme: myTheme)
        
        myForm.build(signUpFormTargetView: targetView)
        
    }

}
