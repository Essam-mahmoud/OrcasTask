//
//  TeamsModel.swift
//  OrcasTask
//
//  Created by Smart Zone on 11/6/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import Foundation
import ObjectMapper

class Teams : BaseModel {
    var id : Int = 0
    var area : Area = Area()
    var name : String = ""
    var shortName : String = ""
    var tla : String = ""
    var crestUrl : String = ""
    var address : String = ""
    var phone : String = ""
    var website : String = ""
    var email : String = ""
    var founded : Int = 0
    var clubColors : String = ""
    var venue : String = ""
    var lastUpdated : String = ""

    override func mapping(map: Map) {

        id <- map["id"]
        area <- map["area"]
        name <- map["name"]
        shortName <- map["shortName"]
        tla <- map["tla"]
        crestUrl <- map["crestUrl"]
        address <- map["address"]
        phone <- map["phone"]
        website <- map["website"]
        email <- map["email"]
        founded <- map["founded"]
        clubColors <- map["clubColors"]
        venue <- map["venue"]
        lastUpdated <- map["lastUpdated"]
    }

}

