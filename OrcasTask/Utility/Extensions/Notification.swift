//
//  Notification.swift
//  glamera
//
//  Created by Smart Zone on 12/23/19.
//  Copyright © 2019 Kerolos Rateeb. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let openSalounDetails =  Notification.Name("openSalounDetails")
    static let openMemberShipDetails =  Notification.Name("openMemberShipDetails")
    
    static let didAddSalounService = Notification.Name("didAddSalounService")
    static let didAddSalounOffer = Notification.Name("didAddSalounOffer")
    static let didAddSalounPackage = Notification.Name("didAddSalounPackage")
    
    static let welcomeScreenNextScreen = Notification.Name("welcomeScreenNextScreen")
}
