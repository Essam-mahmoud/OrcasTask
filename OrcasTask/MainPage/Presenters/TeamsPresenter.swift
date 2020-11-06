//
//  TeamsPresenter.swift
//  OrcasTask
//
//  Created by Smart Zone on 11/6/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import Foundation

class TeamsPresenter{
    var teams = LegaModel()
    var teamsView: TeamsViewController?
    
    init(teamsView: TeamsViewController) {
        self.teamsView = teamsView
    }
}
