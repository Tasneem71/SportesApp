//
//  LeagueEventsViewController.swift
//  SportsApp
//
//  Created by Esraa on 21/04/2021.
//

import UIKit

class LeagueEventsViewController: UIViewController {
    @IBOutlet weak var upcommingCollectionView: UICollectionView!
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    @IBOutlet weak var lastEventsTableView: UITableView!
    
    
    var lastEventsArray = [DatumLastEvents]()
    var upcommingEventsArray = [DatumLastEvents]()
    var lastEvents = [Events]()
    let lastEventsViewModel = LeagueEventsViewModel()
    var teams = [String]()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.upcommingCollectionView.delegate = self
        self.upcommingCollectionView.dataSource = self
        self.teamsCollectionView.delegate = self
        self.teamsCollectionView.dataSource = self
        lastEventsTableView.delegate=self
        lastEventsTableView.dataSource=self
        
        lastEventsViewModel.fetchLastEventsDataFromAPI(leagueID: "4328")
        
        
        lastEventsViewModel.bindLastEventsViewModelToView = {
                    
            self.onSuccessUpdateView()
            
        }
        
        lastEventsViewModel.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
            
        }
        
        
        
        
        lastEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa", employeeSalary: 2, employeeAge: 3, profileImage: "placeholde"))
        lastEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa1", employeeSalary: 2, employeeAge: 3, profileImage: "placeholde"))
        lastEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa2", employeeSalary: 2, employeeAge: 3, profileImage: "placeholde"))

        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa", employeeSalary: 2, employeeAge: 3, profileImage: "placeholde"))
        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa1", employeeSalary: 2, employeeAge: 3, profileImage: "placeholde"))
        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa2", employeeSalary: 2, employeeAge: 3, profileImage: "placeholde"))
        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa", employeeSalary: 2, employeeAge: 3, profileImage: "placeholde"))
        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa1", employeeSalary: 2, employeeAge: 3, profileImage: "placeholde"))
        upcommingEventsArray.append(DatumLastEvents(id: 1, employeeName: "esraa2", employeeSalary: 2, employeeAge: 3, profileImage: "placeholde"))
        
        teams.append("placeholde")
        teams.append("placeholde")
        teams.append("placeholde")
        teams.append("placeholde")
        teams.append("placeholde")
    }
    
    
    
    func onSuccessUpdateView(){
        
        lastEvents = lastEventsViewModel.lastEvents.events!
        self.lastEventsTableView.reloadData()
        
    }
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: lastEventsViewModel.showError, preferredStyle: .alert)
        
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
        cell.imageView1.image = UIImage(named: "placeholde")
        cell.view1.layer.cornerRadius = 20.0
        cell.imageViw2.image = UIImage(named: "placeholde")
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
            return upcommingEventsArray.count
        }else{
            return teams.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == upcommingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellh1", for: indexPath as IndexPath) as! UpCommingCollectionViewCell
            cell.labelCounter1.text = "2"
            cell.labelCounter2.text = "3"
            cell.imageView1.image = UIImage(named: "placeholde")
            cell.view1.layer.cornerRadius = 20.0
            cell.imageView2.image = UIImage(named: "placeholde")
            cell.view2.layer.cornerRadius = 20.0
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellh2", for: indexPath as IndexPath) as! TeamsCollectionViewCell
            cell.teamImageViw.image = UIImage(named: "placeholde")
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
}
