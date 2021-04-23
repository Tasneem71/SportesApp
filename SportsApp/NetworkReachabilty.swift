//
//  NetworkReachabilty.swift
//  SportsApp
//
//  Created by Donia Ashraf on 4/24/21.
//  Copyright © 2021 tasneem. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
