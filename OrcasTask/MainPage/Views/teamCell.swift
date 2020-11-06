//
//  teamCell.swift
//  OrcasTask
//
//  Created by Smart Zone on 11/6/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import UIKit

class teamCell: UITableViewCell {


    //MARK:- Outlets
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var colorLBL: UILabel!
    @IBOutlet weak var venueLBL: UILabel!
    
    //MARK:- Properities
    var linkPressed: ((teamCell)-> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(team: Teams){
        nameLBL.text = team.name
        websiteButton.setTitle(team.crestUrl, for: .normal)
        colorLBL.text = team.clubColors
        venueLBL.text = team.venue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func linkBtn(_ sender: UIButton) {
        linkPressed?(self)
    }
}
