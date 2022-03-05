//
//  HomeViewController.swift
//  Instforma
//
//  Created by David NGUYEN on 28/02/2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let myTheme = Theme(name: "Autumn", inputHeight: 20, inputWidth: 100, inputRadius: 0.5, inputPadding: 0.3, inputMargin: 0.3, textColor: UIColor.red, buttonColor: UIColor.blue, baseColor: UIColor.brown, backgroundColor: UIColor.cyan)
        
        let scrollView = UIScrollView()
        
        let myForm = Form(theme: myTheme)
        
        myForm.build(targetView: scrollView)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleSignin() {
        let signinController = SigninViewController()
        self.navigationController?.pushViewController(signinController, animated: true)
    }
    
    
    @IBAction func handleSignup() {
        let signupController = SignupViewController()
        self.navigationController?.pushViewController(signupController, animated: true)
    }
    
}
