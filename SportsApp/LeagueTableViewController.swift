//
//  LeagueTableViewController.swift
//  SportsApp
//
//  Created by tasneem on 4/21/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import UIKit

class LeagueTableViewController: UITableViewController {
    
    var favorites=[Countrys]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLeaguesFromApi(sport: "Soccer")

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        cell.leagueStr.text = favorites[indexPath.row].strLeague!
        
        if case let cell.leagueImg=cell.leagueImg{
            cell.leagueImg.sd_setImage(with: URL(string:favorites[indexPath.row].strBadge!), placeholderImage: UIImage(named: "placeholde"))
            
            cell.leagueImg.layer.cornerRadius = cell.leagueImg.frame.width / 2
            cell.leagueImg.clipsToBounds = true
        }
        
        if(favorites[indexPath.row].strYoutube!==nil || favorites[indexPath.row].strYoutube!=="" ){
                   cell.youtubeBtn.isHidden=true
               }else{
                   cell.youtubeBtn.isHidden=false
               }
               
               cell.youtubeStr=favorites[indexPath.row].strYoutube!
        
        
        //cell.leagueImg.image = UIImage(named: "image.jpg")
        
        return cell
        
    }
    
    
    
    
    func getLeaguesFromApi(sport:String) {
        
        //"https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=Soccer"
        
        SportsApiServies.instance.getCountries(url:URLs.getLeagueURL+sport)  { (countries, error) in
        if let myError = error{
            print(myError)
        }else{
            guard let countries = countries else {
                return
            }
            self.favorites=countries.countrys!
            
            DispatchQueue.main.async {
             self.tableView.reloadData()
            }
         
            for item in self.favorites{
                print(item.strLeague)}
            }
            
        }
        
    }


}
