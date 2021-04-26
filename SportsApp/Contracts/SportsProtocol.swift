//
//  SportsProtocol.swift
//  SportsApp
//
//  Created by Donia Ashraf on 4/26/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import Foundation
protocol SportsProtocol {
    func getSports(url:String,completion: @escaping (SportObj?,Error?)->Void)

}
 
