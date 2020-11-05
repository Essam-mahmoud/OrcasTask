//
//  ExpiredRequest.swift
//  glamera
//
//  Created by Kerolos Fahem on 13/02/19.
//  Copyright © 2018 Kerolos Fahem. All rights reserved.
//


import Foundation

class ExpiredRequest: NSObject {
    
    static var request = ExpiredRequest()
    
    var expiredRequest : [RequestConfiguraton] = [RequestConfiguraton]()
}
