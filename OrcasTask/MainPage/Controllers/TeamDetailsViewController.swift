//
//  TeamDetailsViewController.swift
//  OrcasTask
//
//  Created by Smart Zone on 11/6/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class TeamDetailsViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet weak var teamNameLBL: UILabel!
    @IBOutlet weak var addressLBL: UILabel!
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    
    //MARK:- Properties
    var teamDetailsPresenter: TeamDetailsPresenter?
    fileprivate let cellName = "PlayersCell"
    var teamId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        teamDetailsPresenter = TeamDetailsPresenter(detailsView: self)
        teamDetailsPresenter?.teamDetails.delegate = self
        setupView()
        getDetailsData()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        playersTableView.delegate = self
        playersTableView.dataSource = self
        playersTableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
    
    func getDetailsData(){
        loadingIndicator.startAnimating()
        teamDetailsPresenter?.teamDetails.getTeamsDetails(id: teamId, success: { (success) in
            self.loadingIndicator.stopAnimating()
            self.teamNameLBL.text = self.teamDetailsPresenter?.teamDetails.name
            self.addressLBL.text = self.teamDetailsPresenter?.teamDetails.address
            self.playersTableView.reloadData()
        }, failure: { (failure) in
            print(failure?.localizedDescription ?? "")
        })
    }
}

extension TeamDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamDetailsPresenter?.teamDetails.squad.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! PlayersCell
        cell.setupCell(player: (teamDetailsPresenter?.teamDetails.squad[indexPath.row])!)
        return cell
    }
    
    
}
