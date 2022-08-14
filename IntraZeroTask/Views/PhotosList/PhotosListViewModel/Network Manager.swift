//
//  Network Manager.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 14/08/2022.
//

import Foundation
import Network

class NetworkManager : ObservableObject {
    @Published var NetworkState : Bool = false
    //TODO: CheckNetworkConnection
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    let monitor = NWPathMonitor()
    
    init(){
        monitor.pathUpdateHandler = { [weak self] pathUpdateHandler  in
            if pathUpdateHandler.status == .satisfied {
                DispatchQueue.main.sync {
                    self?.NetworkState = true
                    
                }
            }
            else{
                self?.NetworkState = false
            }
        }
        
        monitor.start(queue: queue)
    }
}
