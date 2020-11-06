//
//  TeamDetailsMOdel.swift
//  OrcasTask
//
//  Created by Smart Zone on 11/6/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class TeamDetails: BaseModel{
    
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
    var squad : [Squad] = [Squad]()
    var lastUpdated : String = ""

    override func mapping(map: Map) {

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
        squad <- map["squad"]
        lastUpdated <- map["lastUpdated"]
    }
    
    func getTeamsDetails(id: Int, success: SuccessClosure?, failure: FailureClosure?) {
        let request = RequestConfiguraton(withRequestMethod: .get, endpoint: Endpoint.user.details.path + "\(id)", encoding: JSONEncoding.default, model: self)
        self.startApiRequest(withRequestConfiguration: request, success: success, failure: failure)
    }
}


class Squad : BaseModel {
    var id : Int = 0
    var name : String = ""
    var position : String = ""
    var dateOfBirth : String = ""
    var countryOfBirth : String = ""
    var nationality : String = ""
    var shirtNumber : String = ""
    var role : String = ""

    override func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        position <- map["position"]
        dateOfBirth <- map["dateOfBirth"]
        countryOfBirth <- map["countryOfBirth"]
        nationality <- map["nationality"]
        shirtNumber <- map["shirtNumber"]
        role <- map["role"]
    }

}

