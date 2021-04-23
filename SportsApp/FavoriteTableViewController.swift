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
    
    var favorites:[NSManagedObject]!
    var favoritesCD:[NSManagedObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                       
        managedContext = appDelegate.persistentContainer.viewContext
        
        getFromDB()
        
        

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
    
    
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    


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
