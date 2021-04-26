//
//  URLs.swift
//  SportsApp
//
//  Created by tasneem on 4/21/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import Foundation


struct URLs {
    
    public static var getLeagueURL : String = "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s="
    
    
    public static var getSportsURL : String = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
    
    public static var getLastEventsURL : String = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    
    public static var getUpcommingEventsURL : String = "https://www.thesportsdb.com/api/v1/json/1/eventsround.php?id="
    
    public static var getTeamsURL : String = "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id="
    
}
