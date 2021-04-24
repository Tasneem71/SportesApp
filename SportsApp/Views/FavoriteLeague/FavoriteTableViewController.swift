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
import Alamofire
class FavoriteTableViewController: UITableViewController {
    var managedContext : NSManagedObjectContext!
    
    var favorites:[NSManagedObject]=[NSManagedObject]()
    var favoritesCD:[NSManagedObject]!
    var leagueObj:Countrys!
    var idLeague=""
    var fdb:FavoriteDataBase!
    let favoriteViewModel=FavoriteViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                       
        managedContext = appDelegate.persistentContainer.viewContext
        favoriteViewModel.fetchAllLeaguesDataFromAPI()
        //fdb=FavoriteDataBase()
        //favorites=fdb.readData()
        //tableView.reloadData()
        //getFromDB()
        
        favoriteViewModel.bindFavoritsViewModelToView = {
                    
            self.onAllSportsSuccessUpdateView()
            
        }
        
        
        favoriteViewModel.bindViewModelErrorToView = {
                    
            self.onFailUpdateView1()
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //getFromDB()
        favoriteViewModel.fetchAllLeaguesDataFromAPI()
    }
    
    func onAllSportsSuccessUpdateView(){
        
        
        favorites = favoriteViewModel.favorits
        self.tableView.reloadData()
        
    }
    
    
    
    func onFailUpdateView1(){
        
       
        let alert = UIAlertController(title: "Error", message: favoriteViewModel.showError, preferredStyle: .alert)
        
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
        
        
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        cell.leagueStr.text = favorites[indexPath.row].value(forKey: "strLeague") as! String?
        
        if case let cell.leagueImg=cell.leagueImg{
            cell.leagueImg.sd_setImage(with: URL(string:favorites[indexPath.row].value(forKey: "strBadge") as! String), placeholderImage: UIImage(named: "placeholde"))
            
            cell.leagueImg.layer.cornerRadius = cell.leagueImg.frame.width / 2
            cell.leagueImg.clipsToBounds = true
        }
        //cell.youtubeBtn.isHidden=true
        
        if(favorites[indexPath.row].value(forKey: "strYoutube") as! String?==nil || favorites[indexPath.row].value(forKey: "strYoutube") as! String?=="" ){
            cell.youtubeBtn.isHidden=true
        }else{
            cell.youtubeBtn.isHidden=false
        }
        
        cell.youtubeStr=favorites[indexPath.row].value(forKey: "strYoutube") as! String
        
        
        
        //cell.leagueImg.image = UIImage(named: "image.jpg")
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        idLeague = (favorites[indexPath.row].value(forKey: "idLeague") as! String?)!
        
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
           print("Deleted")
            removeFromDB(obj: favorites[indexPath.row])

           self.favorites.remove(at: indexPath.row)
           self.tableView.deleteRows(at: [indexPath], with: .automatic)
         }
       }

    
    
   
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc : LeagueEventsViewController = segue.destination as! LeagueEventsViewController
        vc.isFavorite=true
        vc.idLeague = self.idLeague
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
     
       //  onFailUpdateView()
        
        if Connectivity.isConnectedToInternet{
        print("network exists")
            return true
        }else{
        
        onFailUpdateView()
        print(" no network exists")

           return false
        }
        
       }
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Alert", message: "No Internet Connection", preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
        }
     alert.addAction(okAction)
          self.present(alert, animated: true, completion: nil)
    }
    
    
    
 
    
    
    
    
    
    func getFromDB() {
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        
            do{
                self.favorites = try self.managedContext.fetch(fetch)
             print("fetch")
             
             
            }catch {
              print("un fetch")
            }
            self.tableView.reloadData()
    }
    
    
    func removeFromDB(obj:NSManagedObject) {
       
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
                       
            do{
             var favorites = try self.managedContext.fetch(fetch)
                    print("fetch")
                            
                for item in favorites {
                    if item == obj {
                    managedContext.delete(obj)
                        
                    }
                    
                }
               try  managedContext.save()
                            
                           }catch {
                             print("un fetch")
                           }
          
    }
    


}



extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.contentMode = UIView.ContentMode.scaleAspectFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true

   // make square(* must to make circle),
   // resize(reduce the kilobyte) and
   // fix rotation.
   self.image = anyImage
  }
}
