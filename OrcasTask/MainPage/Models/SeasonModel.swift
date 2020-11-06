//
//  SeasonModel.swift
//  OrcasTask
//
//  Created by Smart Zone on 11/6/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import Foundation
import ObjectMapper


class Season : BaseModel {
    var id : Int?
    var startDate : String?
    var endDate : String?
    var currentMatchday : Int?
    var winner : String?

    override func mapping(map: Map) {

        id <- map["id"]
        startDate <- map["startDate"]
        endDate <- map["endDate"]
        currentMatchday <- map["currentMatchday"]
        winner <- map["winner"]
    }

}

class Area : BaseModel {
    var id : Int?
    var name : String?

    override func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
    }

}


class Competition : BaseModel {
    var id : Int?
    var area : Area?
    var name : String?
    var code : String?
    var plan : String?
    var lastUpdated : String?
    
    override func mapping(map: Map) {

        id <- map["id"]
        area <- map["area"]
        name <- map["name"]
        code <- map["code"]
        plan <- map["plan"]
        lastUpdated <- map["lastUpdated"]
    }

}
