//
//  LeagueEventsViewModel.swift
//  SportsApp
//
//  Created by tasneem on 4/22/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import Foundation


class LeagueEventsViewModel: NSObject {
    
    var service :SportsApiServies!
    
    var lastEvents :LastUpcommingEvents! {
        didSet{
            
            self.bindLastEventsViewModelToView()
        }
        
    }
    
    var upcommingEvents :LastUpcommingEvents! {
        didSet{
            
            self.bindLastEventsViewModelToView()
        }
        
    }
    
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindLastEventsViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.service = SportsApiServies()
        //self.fetchLastEventsDataFromAPI()
    }
    
    
    func fetchLastEventsDataFromAPI (leagueID:String){
                
        service.getEvents(url: URLs.getLastEventsURL+leagueID, completion: { (events, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.lastEvents = events
                
            }
           
        })
    }
    
    
    func fetchUpcommingEventsDataFromAPI (leagueID:String){
                
        service.getEvents(url: URLs.getUpcommingEventsURL+leagueID+"&r=10&s=2012-2021", completion: { (events, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.lastEvents = events
                
            }
           
        })
    }
    
    

}
