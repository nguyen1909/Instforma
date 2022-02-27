//
//  MainViewController.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 22/01/2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var formView: UIView!
    var fileRepository: IFileRepository!

    var themes: [ThemesFile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.fileRepository = (UIApplication.shared.delegate as? AppDelegate)!.dependencyModule.fileRepository

        
        //preparation
        let myTheme = Theme(name: "Autumn", inputRadius: 0.5, inputPadding: 0.3, inputMargin: 0.3, textColor: UIColor.red, buttonColor: UIColor.blue, baseColor: UIColor.brown, backgroundColor: UIColor.cyan)
        let title = myTheme.name
        let fullStrign = myTheme.description
        
        //save le theme autumn
        self.fileRepository.save(theme: ThemesFile(identifier: title, data: fullStrign.data(using: .utf8)!), options: .init(override: true)) { err in
            guard err == nil else {
                return
            }
        }
        
        self.fileRepository.getAll { err, items in
            guard let allThemes = items else {
                self.themes = []
                return
            }
            //[0] pour recuperer seulement le premier theme
            guard let stringData = allThemes[0].data else {
                return
            }            
            let stringTheme = String(data: stringData, encoding: .utf8)!
            
            //initialiser le theme a partir d'une string
            let newThemeNow = Theme(data: stringTheme)
            print (newThemeNow.description)
        }
        
        
        
        /*
        let scoreLabel = UILabel()
        //scoreLabel.backgroundColor = theme.backgroundColor
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        formView.addSubview(scoreLabel)
         */

        // Do any additional setup after loading the view.
    }



}
