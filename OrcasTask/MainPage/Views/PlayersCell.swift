//
//  PlayersCell.swift
//  OrcasTask
//
//  Created by Smart Zone on 11/6/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import UIKit

class PlayersCell: UITableViewCell {

    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var postionLBL: UILabel!
    @IBOutlet weak var nationalityLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(player: Squad){
        nameLBL.text = player.name
        postionLBL.text = player.position
        nationalityLBL.text = player.nationality
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
