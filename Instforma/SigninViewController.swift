//
//  SigninViewController.swift
//  Instforma
//
//  Created by David NGUYEN on 28/02/2022.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var targetView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //user fournit un tableau des inputs
        
        
        let myTheme = Theme(name: "Autumn", inputHeight: 50, inputWidth: 300, inputRadius: 5, inputPadding: 15, inputMargin: 5, textColor: UIColor.black, buttonColor: UIColor.gray, baseColor: UIColor.brown, backgroundColor: UIColor.yellow)
                
        let myForm = Form(theme: myTheme)
        
        myForm.build(signInFormTargetView: targetView)
        
        //user cree un bouton


        // Do any additional setup after loading the view.
    }
    
    
    

}
