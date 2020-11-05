//
//  Language.swift
//  Glamera Business
//
//  Created by Mohamed Kamal on 29-04-2020.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import Foundation

class Language{
    
    class func currentLanguage() -> String{
        
        let def = UserDefaults.standard
        let langs = def.object(forKey: "AppleLanguages") as! NSArray
        let firstLang = langs.firstObject as! String
        
        return firstLang
        
    }
    
    class func setAppLanguage(lang: String){
        let def = UserDefaults.standard
        def.set([lang, currentLanguage()], forKey: "AppleLanguages")
        def.synchronize()
    }
}
