//
//  FavoriteViewMovel.swift
//  SportsApp
//
//  Created by tasneem on 4/24/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import Foundation
import CoreData

class FavoriteViewModel: NSObject {
    var dataBase:FavoriteDataBase!
    
    var favorits :[NSManagedObject]! {
        didSet{

            self.bindFavoritsViewModelToView()
        }

    }
    
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    var bindFavoritsViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        super .init()
        dataBase = FavoriteDataBase()
        //self.fetchAllLeaguesDataFromAPI()
    }
    
    
    func fetchAllLeaguesDataFromAPI (){
                
        dataBase.getCountries( completion: { (league, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.favorits = league
                
            }
           
        })
    }
    
    
   
    

}

