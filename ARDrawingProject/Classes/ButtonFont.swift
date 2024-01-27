//
//  ButtonFont.swift
//  ARDrawingProject
//
//  Created by Raza on 26/12/2023.
//


import UIKit
class FontDictonary {
    var allFont: [String: [String: String]] = [:]
    static let fontDictionary = FontDictonary()
    private init() {}
    func populate(key: String, customFonts: [String: String]){
        allFont[key]?["name"] = customFonts["name"]
        allFont[key]?["size"] = customFonts["size"]
        FontDictonary.fontDictionary.allFont["body1"] = ["name" : "Montserrat-Bold", "size":  "30"]
        
        
    }
}


extension UIButton{
    @IBInspectable var style: String {
//        set{
//            self.titleLabel?.font = UIFont(name: (FontDictonary.fontDictionary.allFont[newValue]?["name"] ?? "Helvetica"), size:        CGFloat(Double(FontDictonary.fontDictionary.allFont[newValue]?["size"] ?? "10.0"), strategy: CGFloat(10.0)))
//        }
        
        set {
                    let fontSizeString = FontDictonary.fontDictionary.allFont[newValue]?["size"] ?? "30"
                    let fontSize = CGFloat(Double(fontSizeString) ?? 30)
                    let fontName = FontDictonary.fontDictionary.allFont[newValue]?["name"] ?? "Montserrat-Bold"
                    self.titleLabel?.font = UIFont(name: fontName, size: fontSize)
                }
        get{
            return ""
        }
    }
}
