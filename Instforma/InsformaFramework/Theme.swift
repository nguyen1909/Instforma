//
//  Theme.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 23/02/2022.
//

import Foundation
import UIKit

public class Theme{
    
    var fileRepository: IFileRepository!

    var name : String
    var inputHeight : Float
    var inputWidth : Float
    var inputRadius : Float
    var inputPadding : Float
    var inputMargin : Float
    var textColor : UIColor
    var buttonColor : UIColor
    var baseColor : UIColor
    var backgroundColor : UIColor
    var description: String {
        return "Theme {\(self.name),\(self.inputWidth),\(self.inputHeight),\(self.inputRadius),\(self.inputPadding),\(self.inputMargin),\(self.textColor),\(self.buttonColor),\(self.baseColor),\(self.backgroundColor)}"
    }
    
    init(name : String, inputHeight : Float, inputWidth : Float, inputRadius : Float, inputPadding : Float, inputMargin : Float, textColor : UIColor, buttonColor : UIColor, baseColor : UIColor, backgroundColor : UIColor){
        self.name = name
        self.inputRadius = inputRadius
        self.inputHeight = inputHeight
        self.inputWidth = inputWidth
        self.inputPadding = inputPadding
        self.inputMargin = inputMargin
        self.textColor = textColor
        self.buttonColor = buttonColor
        self.baseColor = baseColor
        self.backgroundColor = backgroundColor
    }
    
    
    convenience init(data : String){
        let substringBegin = data.substring(from: 7)
        let themeItems = substringBegin.components(separatedBy: ",")

        
        
        self.init(name : themeItems[0],
                  inputHeight : Float(themeItems[1]) ?? 0.0,
                  inputWidth : Float(themeItems[2]) ?? 0.0,
                  inputRadius : Float(themeItems[3]) ?? 0.0,
                  inputPadding : Float(themeItems[4]) ?? 0.0,
                  inputMargin : Float(themeItems[5]) ?? 0.0,
                  textColor : UIColor(named: themeItems[6]) ?? UIColor.red,
                  buttonColor : UIColor(named :themeItems[7]) ?? UIColor.red,
                  baseColor : UIColor(named: themeItems[8]) ?? UIColor.red,
                  backgroundColor : UIColor(named: themeItems[9]) ?? UIColor.red)
    }
    
    public func saveNewTheme(title : String) -> Void {
        let myThemeAsString = self.description
        self.fileRepository.save(themeFile: ThemesFile(identifier: title, data: myThemeAsString.data(using: .utf8)), options: .init(override: true)) { err in
            guard err == nil else {
                return
            }
        }
    }
    

}


extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}



//Du coup on peut encrire le theme sous le format de string,
//Ainsi il faut faire un toString de l'objet Theme et apres il faut aussi ecrire un constructeur qui prend une chaine de chars en param et retourne un Theme

/*
Pour recuperer tout les Themes
 Ca sera dans la classe Form
 self.fileRepository.getAll { err, items in
     guard let themes = items else {
         self.themes = []
         return
     }
     self.themes = themes
 }




 */
