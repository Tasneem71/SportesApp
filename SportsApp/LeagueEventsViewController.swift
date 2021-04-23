//
//  LeagueEventsViewController.swift
//  SportsApp
//
//  Created by tasneem on 21/04/2021.
//

import UIKit

import CoreData

class LeagueEventsViewController: UIViewController {
    @IBOutlet weak var upcommingCollectionView: UICollectionView!
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    @IBOutlet weak var lastEventsTableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var favoriteBtn: UIButton!
    
    var lastEvents = [Events]()
    var upcommingEvents = [Events]()
    var leagueTeams = [Teams]()
    let leagueEventsViewModel = LeagueEventsViewModel()

    var leagueObj:Countrys?
    
    var teamDetails:Teams?
    var managedContext : NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.upcommingCollectionView.delegate = self
        self.upcommingCollectionView.dataSource = self
        self.teamsCollectionView.delegate = self
        self.teamsCollectionView.dataSource = self
        lastEventsTableView.delegate=self
        lastEventsTableView.dataSource=self
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        self.scrollView.contentSize = CGSize(width: screenWidth, height: 970)
        self.scrollView.frame = CGRect(x: 0, y: 70, width: screenWidth, height: screenHeight)
        scrollView.backgroundColor = UIColor.clear
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                       
        managedContext = appDelegate.persistentContainer.viewContext
        
        
        print(leagueObj?.idLeague)
        
        
        leagueEventsViewModel.fetchTeamsDataFromAPI(leagueID: (leagueObj?.idLeague)!)
        leagueEventsViewModel.fetchLastEventsDataFromAPI(leagueID: (leagueObj?.idLeague)!)
        leagueEventsViewModel.fetchUpcommingEventsDataFromAPI(leagueID: (leagueObj?.idLeague)!)
        
        
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
        
        if let event = leagueEventsViewModel.upcommingEvents.events {
            upcommingEvents = leagueEventsViewModel.upcommingEvents.events!
        }
        
        
        self.upcommingCollectionView.reloadData()
        
    }
    
    func onLeagueTeamsSuccessUpdateView(){
        
        if let team = leagueEventsViewModel.leagueTeams.teams{
            leagueTeams = leagueEventsViewModel.leagueTeams.teams!
        }
        
        
        self.teamsCollectionView.reloadData()
        self.upcommingCollectionView.reloadData()
        self.lastEventsTableView.reloadData()
        
    }
    
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: leagueEventsViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            
        }
    }
    
    
    @IBAction func favoriteBtn(_ sender: Any) {
        addToFavorite(leagueItem: leagueObj!)
        favoriteBtn.tintColor=UIColor.red
        
    }
    
   
    
    
        func addToFavorite(leagueItem:Countrys) {
            
            
            let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)
                let favoriteItem = NSManagedObject(entity: entity!, insertInto: managedContext)
            favoriteItem.setValue(leagueItem.idLeague!, forKey: "idLeague")
            favoriteItem.setValue(leagueItem.strLeague!, forKey: "strLeague")
                favoriteItem.setValue(leagueItem.strBadge!, forKey: "strBadge")
                favoriteItem.setValue(leagueItem.strYoutube!, forKey: "strYoutube")
                do{
                    try managedContext.save()
                }catch let error as NSError{
                    print(error)
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
        
        if let teamOne = lastEvents[indexPath.row].idHomeTeam {
            var pics=getTeamPic(teamOneId: lastEvents[indexPath.row].idHomeTeam!, teamTwoId: lastEvents[indexPath.row].idAwayTeam!, teams: leagueTeams)
            cell.imageView1.sd_setImage(with: URL(string:pics[0]), placeholderImage: UIImage(named: "placeholde"))
            
             cell.imageViw2.sd_setImage(with: URL(string:pics[1]), placeholderImage: UIImage(named: "placeholde"))
        }
        
        
        
        
        cell.view1.layer.cornerRadius = 20.0
       
        cell.view2.layer.cornerRadius = 20.0
        cell.dateLabelView.text=lastEvents[indexPath.row].dateEvent
        cell.homeTeamLabel.text=lastEvents[indexPath.row].strHomeTeam
        cell.awayTeamLabel.text=lastEvents[indexPath.row].strAwayTeam
        cell.eventLabel.text=lastEvents[indexPath.row].strEvent
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
            
            cell.homeTeamLabel.text=upcommingEvents[indexPath.row].strHomeTeam
            cell.awayTeamLabel.text=upcommingEvents[indexPath.row].strAwayTeam
            cell.eventLabel.text=upcommingEvents[indexPath.row].strEvent
            
            
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
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        teamDetails=leagueTeams[indexPath.row]
        
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc : TeamDetailsViewController = segue.destination as! TeamDetailsViewController
        vc.team = self.teamDetails
        //print("prepatre"+(leagueObj?.idLeague)!)
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
