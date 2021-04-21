//
//  FavoriteTableViewController.swift
//  SportsApp
//
//  Created by tasneem on 4/20/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class FavoriteTableViewController: UITableViewController {
    var managedContext : NSManagedObjectContext!
    
    var favorites=[Countrys]()
    var favoritesCD:[NSManagedObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                       
        managedContext = appDelegate.persistentContainer.viewContext
        
        
        SportsApiServies.instance.getCountries(url: "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=Soccer" )  { (countries, error) in
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
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
        }
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        cell.leagueStr.text = favorites[indexPath.row].strLeague!
        
        cell.leagueImg!.sd_setImage(with: URL(string:favorites[indexPath.row].strBadge!), placeholderImage: UIImage(named: "image.jpg"))
        
        //cell.leagueImg.image = UIImage(named: "image.jpg")
        
        return cell
        
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
            //self.navigationController!.popViewController(animated: true)
            
//            let vc:myViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailes") as! myViewController
//            self.navigationController?.pushViewController(vc, animated: true)
            
        
        
        
    }
    
    func getFromApi(url:String) {
        
        SportsApiServies.instance.getCountries(url: "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=Soccer" )  { (countries, error) in
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
            
            func getFromDB() {
                let fetch = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
                
                    do{
                        self.favoritesCD = try self.managedContext.fetch(fetch)
                     print("fetch")
                     
                     
                    }catch {
                      print("un fetch")
                    }
                    self.tableView.reloadData()
            }
    
    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
