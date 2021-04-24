//
//  LeagueTableViewController.swift
//  SportsApp
//
//  Created by tasneem on 4/21/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import UIKit

class LeagueTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var sportName=""
    var isFiltered=false
    
    var favorites=[Countrys]()
    var filteredLeague=[Countrys]()
    
    var leagueObj:Countrys?
    var leaguesViewModel=LeaguesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title=""
        //self.getLeaguesFromApi(sport: sportName)
        leaguesViewModel.fetchAllLeaguesDataFromAPI(sportType: sportName)
        searchBar.delegate=self
        
        
        leaguesViewModel.bindLeaguesViewModelToView = {
                    
            self.onAleaguesSuccessUpdateView()
            
        }
        
        
        leaguesViewModel.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
            
        }
    
        
    }
    
    
    func onAleaguesSuccessUpdateView(){
        
        print("on success")
        favorites = leaguesViewModel.leagues.countrys!
        self.filteredLeague=self.favorites
        self.tableView.reloadData()
        
    }
    
    
    
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: leaguesViewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
        
        }
        alert.addAction(okAction)
             self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
//        if isFiltered {
//            return filteredLeague.count
//        }else{
//                return favorites.count
//        }
        
        return filteredLeague.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        
        //if isFiltered {
            cell.leagueStr.text = filteredLeague[indexPath.row].strLeague!
            
            if  let image = filteredLeague[indexPath.row].strBadge{
                cell.leagueImg.sd_setImage(with: URL(string:filteredLeague[indexPath.row].strBadge!), placeholderImage: UIImage(named: "placeholde"))
                
                cell.leagueImg.layer.cornerRadius = cell.leagueImg.frame.width / 2
                cell.leagueImg.clipsToBounds = true
            }
        
        
        if let youtube = filteredLeague[indexPath.row].strYoutube {
            
            if(filteredLeague[indexPath.row].strYoutube!==nil || filteredLeague[indexPath.row].strYoutube!=="" ){
                cell.youtubeBtn.isHidden=true
            }else{
                cell.youtubeBtn.isHidden=false
            }
            
            cell.youtubeStr=filteredLeague[indexPath.row].strYoutube!
            
        }
            
            
        
        
        
        
        
        return cell
        
    }
    
    

    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        leagueObj=filteredLeague[indexPath.row]
        print("didselect"+(leagueObj?.idLeague)!)
        return indexPath
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc : LeagueEventsViewController = segue.destination as! LeagueEventsViewController
        vc.isFavorite=false
        vc.leagueObj = self.leagueObj
        print("prepatre"+(leagueObj?.idLeague)!)
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
                self.filteredLeague=self.favorites
             self.tableView.reloadData()
            }
         
            for item in self.favorites{
                print(item.strLeague)}
            }
            
        }
        
    }


}

extension LeagueTableViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if(searchText.count==0){
//            isFiltered=false
//        }else{
//            isFiltered=true
            
            filteredLeague = searchText.isEmpty ? favorites : favorites.filter({(dataString: Countrys) -> Bool in
                   // If dataItem matches the searchText, return true to include it
                return dataString.strLeague!.range(of: searchText, options: .caseInsensitive) != nil
            
//            for item in favorites {
//                var rang:Range=item.strLeague?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil)
//            }
                print("tasneem")
            
        })
            
            

    //}
        self.tableView.reloadData()
    
    }
    
}
