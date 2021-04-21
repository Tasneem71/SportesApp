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
