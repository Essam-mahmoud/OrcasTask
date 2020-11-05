//
//  DictionaryExtension.swift
//  glamera
//
//  Created by Smart Zone on 12/23/19.
//  Copyright © 2019 Kerolos Rateeb. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func combine(withOther other: Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    func toString() -> String {
        var str = "{"
        self.forEach({str += "\"\($0)\": \($1),"})
        str += "}"
        return str
    }
}
