//
//  MainViewController.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 22/01/2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var formView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scoreLabel = UILabel()
        //scoreLabel.backgroundColor = theme.backgroundColor
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        formView.addSubview(scoreLabel)

        // Do any additional setup after loading the view.
    }



}
