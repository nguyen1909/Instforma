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
