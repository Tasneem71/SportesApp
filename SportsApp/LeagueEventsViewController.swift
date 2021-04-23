//
//  LeagueEventsViewController.swift
//  SportsApp
//
//  Created by tasneem on 21/04/2021.
//

import UIKit

class LeagueEventsViewController: UIViewController {
    @IBOutlet weak var upcommingCollectionView: UICollectionView!
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    @IBOutlet weak var lastEventsTableView: UITableView!
    
    
    var lastEvents = [Events]()
    var upcommingEvents = [Events]()
    var leagueTeams = [Teams]()
    let leagueEventsViewModel = LeagueEventsViewModel()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.upcommingCollectionView.delegate = self
        self.upcommingCollectionView.dataSource = self
        self.teamsCollectionView.delegate = self
        self.teamsCollectionView.dataSource = self
        lastEventsTableView.delegate=self
        lastEventsTableView.dataSource=self
        
        
        
        
        
        leagueEventsViewModel.fetchTeamsDataFromAPI(leagueID: "4328")
        leagueEventsViewModel.fetchLastEventsDataFromAPI(leagueID: "4328")
        leagueEventsViewModel.fetchUpcommingEventsDataFromAPI(leagueID: "4328")
        
        
        leagueEventsViewModel.bindUpcommingEventsViewModelToView = {
                    
            self.onUpcommingEventSuccessUpdateView()
            
        }
        
        leagueEventsViewModel.bindLastEventsViewModelToView = {
                    
            self.onLastEventSuccessUpdateView()
            
        }
        
        leagueEventsViewModel.bindLeagueTeamsViewModelToView = {
                    
            self.onLeagueTeamsSuccessUpdateView()
            
        }
        
        
        leagueEventsViewModel.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
            
        }
        
        
    
    }
    
    
    
    func onLastEventSuccessUpdateView(){
        
        lastEvents = leagueEventsViewModel.lastEvents.events!
        self.lastEventsTableView.reloadData()
        
    }
    
    
    func onUpcommingEventSuccessUpdateView(){
        
        upcommingEvents = leagueEventsViewModel.upcommingEvents.events!
        self.upcommingCollectionView.reloadData()
        
    }
    
    func onLeagueTeamsSuccessUpdateView(){
        
        leagueTeams = leagueEventsViewModel.leagueTeams.teams!
        self.teamsCollectionView.reloadData()
        self.upcommingCollectionView.reloadData()
        self.lastEventsTableView.reloadData()
        
    }
    
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: leagueEventsViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            
        }
    }
    
    
    
    
}

//Last 15 Events by League Id
//https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=4328
//
//
//List all Teams in a League
//https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League

extension LeagueEventsViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lastEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! LastEventesTableViewCell
        cell.countLabelView1.text = lastEvents[indexPath.row].intHomeScore
        cell.countLabelView2.text = lastEvents[indexPath.row].intAwayScore
        var pics=getTeamPic(teamOneId: lastEvents[indexPath.row].idHomeTeam!, teamTwoId: lastEvents[indexPath.row].idAwayTeam!, teams: leagueTeams)
        cell.imageView1.sd_setImage(with: URL(string:pics[0]), placeholderImage: UIImage(named: "placeholde"))
        cell.view1.layer.cornerRadius = 20.0
        cell.imageViw2.sd_setImage(with: URL(string:pics[1]), placeholderImage: UIImage(named: "placeholde"))
        cell.view2.layer.cornerRadius = 20.0
        cell.dateLabelView.text=lastEvents[indexPath.row].dateEvent
        return cell
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 170.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Last Events"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
}


extension LeagueEventsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == upcommingCollectionView {
            return upcommingEvents.count
        }else{
            return leagueTeams.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == upcommingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellh1", for: indexPath as IndexPath) as! UpCommingCollectionViewCell
            cell.labelCounter1.text = upcommingEvents[indexPath.row].intHomeScore
            cell.labelCounter2.text = upcommingEvents[indexPath.row].intAwayScore
            
            
            var pics=getTeamPic(teamOneId: upcommingEvents[indexPath.row].idHomeTeam!, teamTwoId: upcommingEvents[indexPath.row].idAwayTeam!, teams: leagueTeams)
            
            
            cell.imageView1.sd_setImage(with: URL(string:pics[0]), placeholderImage: UIImage(named: "placeholde"))
            cell.view1.layer.cornerRadius = 20.0
            cell.imageView2.sd_setImage(with: URL(string:pics[1]), placeholderImage: UIImage(named: "placeholde"))
            cell.view2.layer.cornerRadius = 20.0
            cell.dateLabeel.text=upcommingEvents[indexPath.row].dateEvent
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellh2", for: indexPath as IndexPath) as! TeamsCollectionViewCell
            cell.teamImageViw.sd_setImage(with: URL(string:leagueTeams[indexPath.row].strTeamBadge!), placeholderImage: UIImage(named: "placeholde"))
            cell.teamImageViw.layer.cornerRadius = cell.teamImageViw.frame.width / 2
            cell.teamImageViw.clipsToBounds = true
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == upcommingCollectionView {
            return CGSize(width: 300, height: 180)
        }else{
            return CGSize(width: 185, height: 144)
        }
    
    
}
    
    func getTeamPic(teamOneId:String,teamTwoId:String,teams:[Teams]) -> [String] {
        var teamspics=["",""]
        for item in teams{
            if teamOneId==item.idTeam {
                teamspics[0]=item.strTeamBadge!
            }
            if teamTwoId==item.idTeam {
                teamspics[1]=item.strTeamBadge!
            }
        }
        return teamspics
    }
    
}
