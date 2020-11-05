//
//  LastReuest.swift
//  glamera
//
//  Created by Kerolos Fahem on 13/02/19.
//  Copyright © 2018 Kerolos Fahem. All rights reserved.
//


import UIKit

class LastRequest: NSObject {

    static var request = LastRequest()

    var lastRequests : [RequestConfiguraton] = [RequestConfiguraton]()
}
