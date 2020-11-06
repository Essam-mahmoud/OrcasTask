//
//  EndPoint.swift
//  glamera
//
//  Created by Kerolos Fahem on 13/02/19.
//  Copyright © 2018 Kerolos Fahem. All rights reserved.
//


import Foundation

struct Endpoint {
    
    enum user {
        case teams
        case details
    }
    
}
extension Endpoint.user {
    var path: String {
        var endpoint = ""
        
        switch self {
            
        case .teams: endpoint = "competitions/2021/teams"
        case .details: endpoint = "teams/"
        }
        
        return endpoint
    }
}




