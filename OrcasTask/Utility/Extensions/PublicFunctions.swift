//
//  PublicFunctions.swift
//  Glamera Business
//
//  Created by Apple on 2/3/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import UIKit

let IsLogin = "IsLogin"
class Helper{
    static func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
    }
}

func createGradientLayer(myView: UIView, color1: String,color2: String) {
       var gradientLayer: CAGradientLayer!
       gradientLayer = CAGradientLayer()
       gradientLayer.frame = myView.bounds
       gradientLayer.colors = [UIColor.hexColorWithAlpha(string: color1, alpha: 1).cgColor, UIColor.hexColorWithAlpha(string: color2, alpha: 1).cgColor]
       myView.layer.addSublayer(gradientLayer)
   }

func saveToDefults(data:String, key: String){
    let userDefaults = UserDefaults.standard
    userDefaults.set(data, forKey: key)
    userDefaults.synchronize()
}

func slidFromRightToLeft(myView: UIView, direction: CATransitionSubtype){
    let transition = CATransition()
    transition.duration = 0.4
    transition.type = CATransitionType.push
    transition.subtype = direction
    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
    myView.window!.layer.add(transition, forKey: kCATransition)
}


