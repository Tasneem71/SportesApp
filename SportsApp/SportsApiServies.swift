//
//  SportsApiServies.swift
//  SportsApp
//
//  Created by tasneem on 4/20/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import Foundation


import Alamofire
class SportsApiServies{
    
    
    //singletone
    //3ashan msh kol shwaya a3ml instance
    static let instance = SportsApiServies()
    
    
    //return clousure esmo completion byakhod model,error --->optional 3ashan
    //law mfesh haga reg3aet
    func getCountries(url:String,completion: @escaping (Json4Swift_Base?,Error?)->Void){
        
        
        
        AF.request(url).responseJSON {(response) in
            guard let data = response.data else{
                return
            }
            switch response.result{

            case .success(let val):
                do{
                   let countries = try JSONDecoder().decode(Json4Swift_Base.self, from: data)

                     completion(countries,nil)
                }catch let jsonError{
                    print(jsonError)
                }

            case .failure(let error):
                completion(nil,error)
                //clousure hwa function ezan lazem anadeha
                //we 3ashan fih error f hakhaly el data el returned --> nil

            }
        }
    }
    
    
    
    
    
    func getSports(url:String,completion: @escaping (SportObj?,Error?)->Void){
        
        
        
        AF.request(url).responseJSON {(response) in
            guard let data = response.data else{
                return
            }
            switch response.result{

            case .success(let val):
                do{
                   let sport = try JSONDecoder().decode(SportObj.self, from: data)

                     completion(sport,nil)
                }catch let jsonError{
                    print(jsonError)
                }

            case .failure(let error):
                completion(nil,error)
                //clousure hwa function ezan lazem anadeha
                //we 3ashan fih error f hakhaly el data el returned --> nil

            }
        }
    }
    
    
    func getEvents(url:String,completion: @escaping (LastUpcommingEvents?,Error?)->Void){
        
        
        
        AF.request(url).responseJSON {(response) in
            guard let data = response.data else{
                return
            }
            switch response.result{

            case .success(let val):
                do{
                   let events = try JSONDecoder().decode(LastUpcommingEvents.self, from: data)

                     completion(events,nil)
                }catch let jsonError{
                    print(jsonError)
                }

            case .failure(let error):
                completion(nil,error)
                //clousure hwa function ezan lazem anadeha
                //we 3ashan fih error f hakhaly el data el returned --> nil

            }
        }
    }
    
    
    
    
}
