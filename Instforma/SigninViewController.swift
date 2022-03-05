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
        
        let myTheme = Theme(name: "Autumn", inputHeight: 50, inputWidth: 300, inputRadius: 5, inputPadding: 15, inputMargin: 5, textColor: UIColor.black, buttonColor: UIColor.gray, baseColor: UIColor.brown, backgroundColor: UIColor.yellow)
                
        let myForm = Form(theme: myTheme)
        
        myForm.build(signInFormTargetView: targetView)

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
