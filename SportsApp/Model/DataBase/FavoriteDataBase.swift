//
//  FavoriteDataBase.swift
//  SportsApp
//
//  Created by tasneem on 4/24/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import Foundation
import CoreData

import UIKit

class FavoriteDataBase{
    
    static var realDelegate: AppDelegate?

    var appDelegate:AppDelegate?
    var managedContext : NSManagedObjectContext!
    
    var favorites:[NSManagedObject]?
    
    init() {
        managedContext = FavoriteDataBase.appDelegate.persistentContainer.viewContext
        appDelegate = AppDelegate()
    }
    
    
    
    
    
    func getCountries(completion: @escaping ([NSManagedObject]?,Error?)->Void){
        

        let managedContext = FavoriteDataBase.appDelegate.persistentContainer.viewContext
         
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        
            do{
                self.favorites = try self.managedContext.fetch(fetch)
                completion(favorites,nil)
             print("fetch")
             
             
            }catch {
              print("un fetch")
            }
        

        //return favorites
    }








    static var appDelegate: AppDelegate {
        if Thread.isMainThread{
            return UIApplication.shared.delegate as! AppDelegate;
        }
        let dg = DispatchGroup();
        dg.enter()
        DispatchQueue.main.async{
            realDelegate = UIApplication.shared.delegate as? AppDelegate;
            dg.leave();
        }
        dg.wait();
        return realDelegate!;
    }

}
