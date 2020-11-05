//
//  Storyboard.swift
//  glamera
//
//  Created by Smart Zone on 12/23/19.
//  Copyright © 2019 Kerolos Rateeb. All rights reserved.
//

import Foundation

enum Storyboard: String {
    case Main
}

extension Storyboard: Name {
    var name: String {
        return self.rawValue
    }
}
