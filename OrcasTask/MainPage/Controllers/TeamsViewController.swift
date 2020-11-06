//
//  TeamsViewController.swift
//  OrcasTask
//
//  Created by Smart Zone on 11/6/20.
//  Copyright © 2020 Smart Zone. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class TeamsViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet weak var teamsTableView: UITableView!
    
    @IBOutlet weak var noDataFoundImage: UIImageView!
    @IBOutlet weak var LoadingIndicator: NVActivityIndicatorView!
    //MARK:- Properities
    var teamPresenter: TeamsPresenter?
    fileprivate let cellName = "teamCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        teamPresenter = TeamsPresenter(teamsView: self)
        teamPresenter?.teams.delegate = self
        setupView()
        getTeamsData()

        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        teamsTableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.blue]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes

        self.navigationController?.navigationBar.topItem?.title = "Premier League Teams"
    }
    
    func getTeamsData(){
        LoadingIndicator.startAnimating()
        teamPresenter?.teams.getTeamsData(success: { (sucess) in
            self.LoadingIndicator.stopAnimating()
            self.teamsTableView.reloadData()
            if self.teamPresenter?.teams.teams.count ?? 0 > 0{
                self.noDataFoundImage.isHidden = true
            }else{
                self.noDataFoundImage.isHidden = false
            }
        }, failure: { (failure) in
            print(failure?.localizedDescription ?? "")
        })
    }
    
    func goToWebsite(url: String){
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
}


extension TeamsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamPresenter?.teams.teams.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! teamCell
        cell.setupCell(team: (teamPresenter?.teams.teams[indexPath.row])!)
        cell.linkPressed = {[weak self] (selectedCell) -> Void in
            self?.goToWebsite(url: (self?.teamPresenter?.teams.teams[indexPath.row].website)!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let detailsView = UIViewController.viewController(withStoryboard: .Main, AndContollerID: "TeamDetailsViewController") as! TeamDetailsViewController
        detailsView.teamId = teamPresenter?.teams.teams[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(detailsView, animated: true)
    }
    
    
}
