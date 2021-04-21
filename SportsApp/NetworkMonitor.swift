//
//  NetworkMonitor.swift
//  Day7CoreDataMovieDemo
//
//  Created by RahmaAyman on 4/11/21.
//  Copyright © 2021 RahmaAyman. All rights reserved.
//

import Foundation
import Network

final class NetworkMonitor{
    
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    
    private let monitor:NWPathMonitor
    
    public private(set) var isConnected:Bool = false
    
    public private(set) var connectionType:ConnectionType = .unKnown
    enum ConnectionType {
        case wifi
        case unKnown
    }
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    
    public func satrtMonitoring(){
        
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {
            [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            
            self?.getConnectionType(path: path)
            print(self?.isConnected ?? "N/A")
        }
        
    }
    
    
    
    
    public func stopMonitoring(){
        monitor.cancel()
    }
   
    
    public func getConnectionType(path :NWPath){
           
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }
        else{
            connectionType = .unKnown
        }
}
}
