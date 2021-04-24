//
//  AllSportsViewModel.swift
//  SportsApp
//
//  Created by tasneem on 4/24/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import Foundation

class AllSportsViewModel: NSObject {
    
    var service :SportsApiServies!
    
    var allSports :SportObj! {
        didSet{
            
            self.bindAllSportsViewModelToView()
        }
        
    }
    
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    var bindAllSportsViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.service = SportsApiServies()
        self.fetchAllSportsDataFromAPI()
    }
    
    
    func fetchAllSportsDataFromAPI (){
                
        service.getSports(url: URLs.getSportsURL, completion: { (sports, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.allSports = sports
                
            }
           
        })
    }
    
    
   
    

}
