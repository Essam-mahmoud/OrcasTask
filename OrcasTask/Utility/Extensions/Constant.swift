//
//  Constant.swift
//  glamera
//
//  Created by Smart Zone on 9/16/19.
//  Copyright © 2019 ahmed ezz. All rights reserved.
//

import UIKit

struct Constant {

    static let mainDomain =  "https://run.mocky.io"

    
    static func getHeader(accessToken: String = "")-> [String:String] {
        var headers = ["":""]

        if accessToken == "" {
            headers = ["Content-Type": "application/json","Lang": "en"]
        }else{
            headers = ["Content-Type": "application/json","Lang": "en"]
        }
        
        return headers
    }
}

//enum Gender {
//    case male
//    case female
//    
//    var rawValue: Int {
//        switch self {
//        case .male: return 1
//        case .female: return 2
//        }
//    }
//}

enum dateFormat : String {
    case format1 = "EEEE, MMM d, yyyy" // Monday, Jul 1, 2019
    case format2 = "MM/dd/yyyy"       // 07/01/2019
    case format3 = "MM-dd-yyyy HH:mm"  // 07-01-2019 16:51
    case format4 = "MMM d, h:mm a"    // Jul 1, 4:51 PM
    case format5 = "MMMM yyyy"        // July 2019
    case format6 = "MMM d, yyyy"      // Jul 1, 2019
    case format7 = "E, d MMM yyyy HH:mm:ss Z"  // Mon, 1 Jul 2019 16:51:22 +0000
    case format8 = "yyyy-MM-dd'T'HH:mm:ssZ"    // 2019-07-01T16:51:22+0000
    case format9 = "dd.MM.yy"                 // 01.07.19
    case format10 = "HH:mm:ss.SSS"            // 16:51:22.914
    case format11 = "yyyy-MM-dd'T'HH:mm:ss"    // 2019-07-01T16:51:22
    case formate12 = "yyy/MM/dd"
    case formate13 = "HH:mm:ss"
    case formate14 = "HH:mm a"
    case formate15 = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
    case formate16 = "dd-MM-yyyy"
    case formate17 = "EEE/dd/MMM/yyyy"    // Mon/07/Jul/2019
}

