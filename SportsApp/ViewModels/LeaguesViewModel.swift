//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by tasneem on 4/24/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import Foundation


class LeaguesViewModel: NSObject {
    
    var service :SportsApiServies!
    
    var leagues :Json4Swift_Base! {
        didSet{
            
            self.bindLeaguesViewModelToView()
        }
        
    }
    
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    var bindLeaguesViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.service = SportsApiServies()
    }
    
    
    func fetchAllLeaguesDataFromAPI (sportType:String){
                
        service.getCountries(url: URLs.getLeagueURL+sportType, completion: { (league, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.leagues = league
                
            }
           
        })
    }
    
    
   
    

}

