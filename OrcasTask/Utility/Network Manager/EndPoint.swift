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
        case main
    }
    
}
extension Endpoint.user {
    var path: String {
        var endpoint = ""
        
        switch self {
            
        case .main: endpoint = "/v3/27867999-8b3e-4c04-a761-42def62ea1e8"
        }
        
        return endpoint
    }
}




