//
//  LegaModel.swift
//  OrcasTask
//
//  Created by Smart Zone on 11/6/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class LegaModel: BaseModel{
    
    var count : Int?
    var competition : Competition?
    var season : Season = Season()
    var teams : [Teams] = [Teams]()

    override func mapping(map: Map) {

        count <- map["count"]
        competition <- map["competition"]
        season <- map["season"]
        teams <- map["teams"]
    }
    
    func getTeamsData(success: SuccessClosure?, failure: FailureClosure?) {
        let request = RequestConfiguraton(withRequestMethod: .get, endpoint: Endpoint.user.teams.path, encoding: JSONEncoding.default, model: self)
        self.startApiRequest(withRequestConfiguration: request, success: success, failure: failure)
    }
}
