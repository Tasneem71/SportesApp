//
//  SportObj.swift
//  SportsApp
//
//  Created by tasneem on 4/21/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import Foundation


struct SportObj: Codable {
    let sports: [Sport]
}

// MARK: - Sport
struct Sport: Codable {
    let idSport, strSport: String
    let strFormat: StrFormat
    let strSportThumb, strSportThumbGreen: String
    let strSportDescription: String
}

enum StrFormat: String, Codable {
    case eventSport = "EventSport"
    case teamvsTeam = "TeamvsTeam"
}
