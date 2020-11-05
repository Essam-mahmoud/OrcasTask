//
//  StringExtension.swift
//  glamera
//
//  Created by Smart Zone on 12/23/19.
//  Copyright © 2019 Kerolos Rateeb. All rights reserved.
//

import UIKit

extension String {
    
    var timeAgo: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let now = Date()
            let earliest = (now as NSDate).earlierDate(date)
            let latest = (earliest == now) ? date : now
            let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
            
            if (components.year! >= 2) {
                return "\(components.year!) years ago"
            } else if (components.year! >= 1){
                return "Last year"
            } else if (components.month! >= 2) {
                return "\(components.month!) months ago"
            } else if (components.month! >= 1){
                return "Last month"
            } else if (components.weekOfYear! >= 2) {
                return "\(components.weekOfYear!) weeks ago"
            } else if (components.weekOfYear! >= 1){
                return "Last week"
            } else if (components.day! >= 2) {
                return "\(components.day!) days ago"
            } else if (components.day! >= 1){
                return "Yesterday"
            } else if (components.hour! >= 2) {
                return "\(components.hour!) hours ago"
            } else if (components.hour! >= 1){
                return "An hour ago"
            } else if (components.minute! >= 2) {
                return "\(components.minute!) minutes ago"
            } else if (components.minute! >= 1){
                return "A minute ago"
            } else if (components.second! >= 3) {
                return "\(components.second!) seconds ago"
            } else {
                return "Just now"
            }
        }

        return ""
    }
    
    func convertToEnglishNumbers()-> NSNumber {
        let formatter = NumberFormatter()
        
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale
        if let final = formatter.number(from: self) {
            return final
        }
        
        return 0
    }
    
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var removedSpaces: String? {
        return self.replacingOccurrences(of: "{0}", with: "")
    }
    
    var underlined: NSAttributedString? {
        return underlined(withColor: .white)
    }
    
    func underlined(withColor color : UIColor) -> NSAttributedString? {
        let color = color
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single, NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: self, attributes: underlineAttribute)
        return attributedString
    }
    
    func formatLocalizedString(withValue newValue: String) -> String{
        return self.replacingOccurrences(of: "{0}", with: newValue)
    }
    
    func formatLocalizedString(firstValue firstStr: String, secondValue secondStr: String) -> String {
        var formattedString = self.replacingOccurrences(of: "{0}", with: firstStr)
        formattedString = formattedString.replacingOccurrences(of: "{1}", with: secondStr)
        return formattedString
    }
    
    ///
    
    /// Calculates string width based on max height and font
    ///
    /// - Parameters:
    ///   - height: max height
    ///   - font: font used
    /// - Returns: text width
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
    
    
    /// Calculates string height based on max width and font
    ///
    /// - Parameters:
    ///   - width: max width
    ///   - font: font uesd
    /// - Returns: text hight
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    func getFullDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let dateObject = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd-MM-yyyy"
       // dateFormatter.dateStyle = .medium
       // dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        if dateObject != nil {
            let date = dateFormatter.string(from: dateObject!)
            return date
        } else {
            return " "
        }
    }
    
    func getStandardDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateObject = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd-MM-yyyy"
       // dateFormatter.dateStyle = .medium
       // dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        if dateObject != nil {
            let date = dateFormatter.string(from: dateObject!)
            return date
        } else {
            return " "
        }
    }
    
    func getServerDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateObject = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy/MM/dd"
       // dateFormatter.dateStyle = .medium
       // dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        if dateObject != nil {
            let date = dateFormatter.string(from: dateObject!)
            return date
        } else {
            return " "
        }
    }
    
    
    func formattedDate(with format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSxxx"
        let dateObject = dateFormatter.date(from: self)
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        if dateObject != nil {
            let date = dateFormatter.string(from: dateObject!)
            return date
        } else {
            return " "
        }
    }
    
    func getCellDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateObject = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "EEE/dd/MMM/yyyy"
       // dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        if dateObject != nil {
            let date = dateFormatter.string(from: dateObject!)
            return date
        } else {
            return " "
        }
    }
    
    func getWorkTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateObject = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "hh:mm a"
       // dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        if dateObject != nil {
            let date = dateFormatter.string(from: dateObject!)
            return date
        } else {
            return " "
        }
    }
    
    func reverseWorkTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let dateObject = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "HH:mm:ss"
       // dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        if dateObject != nil {
            let date = dateFormatter.string(from: dateObject!)
            return date
        } else {
            return " "
        }
    }
    
    func getTimeFromDate() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
           let dateObject = dateFormatter.date(from: self)
           dateFormatter.dateFormat = "hh:mm a"
           //dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
           if dateObject != nil {
               let date = dateFormatter.string(from: dateObject!)
               return date
           } else {
               return " "
           }
       }
    
    func multipleFontString(withUniqueText unique: String, uiniqueFont uniqueFont: UIFont, andNormalFont normalFont: UIFont) -> NSAttributedString {
        let string = NSString(string: self)
        let differentRange = string.range(of: unique)
        if differentRange.location != NSNotFound {
            let allAttr = [NSAttributedString.Key.font: normalFont]
            let vodafoneAttr = [NSAttributedString.Key.font: uniqueFont]
            
            let attributedText = NSMutableAttributedString(string: self, attributes: allAttr)
            attributedText.addAttributes(vodafoneAttr, range: differentRange)
            
            return attributedText
        }
        return NSAttributedString()
    }
    
    //: ### Base64 encoding a string
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    //: ### Base64 decoding a string
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func validatePhoneNumber() -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    
    func isURL () -> Bool {
        
        if let url  = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
    func deCodeImage () -> UIImage? {
        if let decodedData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedData)
            return image
        }
        
        return nil
    }
    
    func withStrik() -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func localized(_ lang: String) -> String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    func stringByAddingPercentEncodingForFormUrlencoded() -> String? {
        let characterSet = NSMutableCharacterSet.alphanumeric()
        characterSet.addCharacters(in: "-._* ")
        
        return addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet)?.replacingOccurrences(of: " ", with: "+")
    }
    
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    
    func vaildStringUrl() -> String {
        guard let url = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invailed String URL")
            return "Invailed String URL"
        }
        return url.replacingOccurrences(of: " ", with: "%20")
    }

    func keepDecimalDigits() -> Int {
        if let number = Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            return number
        }
        print("keep Decimal Digits has fialed")
        return -1
    }
    
    func keepDoubleNumbers()-> Double {
        return NumberFormatter().number(from: self)?.doubleValue ?? 0.0
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

}


extension String {
    //Converts String to Int
    public func toInt() -> Int {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return 0
        }
    }
    
    //Converts String to Double
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// EZSE: Converts String to Float
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    //Converts String to Bool
    public func toBool() -> Bool? {
        return (self as NSString).boolValue
    }
}

