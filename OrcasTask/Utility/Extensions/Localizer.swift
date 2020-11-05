//
//  Localizer.swift
//  Glamera Business
//
//  Created by Mohamed Kamal on 29-04-2020.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import Foundation

class Localizer{
    
    class func doExchange(){
        exchangeMethodForClass(className: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.customLocalizedString(forKey:value:table:)))
    }
}

extension Bundle{
    @objc func customLocalizedString(forKey: String, value: String?, table tableName: String) -> String{
        
        let currentLang = Language.currentLanguage()
        
        var bundle = Bundle()
        if let path = Bundle.main.path(forResource: currentLang, ofType: "lproj"){
            bundle = Bundle(path: path)!
        }else{
            let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
            bundle = Bundle(path: path!)!
        }
        
        return bundle.customLocalizedString(forKey: forKey, value: value, table: tableName)
    }
}

func exchangeMethodForClass(className: AnyClass, originalSelector: Selector, overrideSelector: Selector){
    
    let originalMethod: Method = class_getInstanceMethod(className, originalSelector)!
    let overrideMethod: Method = class_getInstanceMethod(className, overrideSelector)!
    if class_addMethod(className, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)){
        class_replaceMethod(className, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    }else{
        method_exchangeImplementations(originalMethod, overrideMethod)
    }
}
