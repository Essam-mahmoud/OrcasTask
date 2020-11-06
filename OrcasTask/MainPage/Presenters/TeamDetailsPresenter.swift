//
//  TeamDetailsPresenter.swift
//  OrcasTask
//
//  Created by Smart Zone on 11/6/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import Foundation

class TeamDetailsPresenter{
    
    var teamDetails = TeamDetails()
    var detailsView: TeamDetailsViewController?
    
    init(detailsView: TeamDetailsViewController) {
        self.detailsView = detailsView
    }
}
