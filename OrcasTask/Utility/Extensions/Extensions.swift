//
//  Extensions.swift
//  Glamera Business
//
//  Created by Apple on 2/3/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import UIKit

extension UIColor{
        class func hexColorWithAlpha(string: String, alpha:CGFloat) -> UIColor {
            let set = NSCharacterSet.whitespacesAndNewlines
            var colorString = string.trimmingCharacters(in: set).uppercased()
            
            if (colorString.hasPrefix("#")) {
                let index = colorString.index(after: colorString.startIndex)
                colorString = String(colorString[index..<colorString.endIndex])
            }
            
            var rgbValue: UInt32 = 0
            Scanner(string: colorString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue:  CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha
            )
            
            
            
        }
}

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }
}
