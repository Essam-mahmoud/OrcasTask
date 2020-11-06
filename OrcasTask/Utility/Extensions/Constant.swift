//
//  Constant.swift
//  glamera
//
//  Created by Smart Zone on 9/16/19.
//  Copyright © 2019 ahmed ezz. All rights reserved.
//

import UIKit

struct Constant {

    static let mainDomain =  "https://api.football-data.org/v2/"

    
    static func getHeader(accessToken: String = "")-> [String:String] {
        var headers = ["":""]

        if accessToken == "" {
            headers = ["Content-Type": "application/json","X-Auth-Token": "125a4acb195e425c81d1807cdb69c5dc"]
        }else{
            headers = ["Content-Type": "application/json","X-Auth-Token": "125a4acb195e425c81d1807cdb69c5dc"]
        }
        
        return headers
    }
}


