//
//  PhotosListViewModel.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import Foundation
import Network
protocol photosListProtocol {
    func getPhotosList()
}
class PhotosListViewModel : ObservableObject , photosListProtocol {

    
    @Published var photosList : [Photo] = [Photo] ()
  
    @Published var NetworkState : Bool = true


    
    
    //MARK: Network
    var networkLayer = NetworkAPI.networkApi
    //TODO: CheckNetworkConnection
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    let monitor = NWPathMonitor()
    
    
    func getPhotosList() {
        monitor.pathUpdateHandler = { [weak self] pathUpdateHandler  in
            if pathUpdateHandler.status == .satisfied {
                  DispatchQueue.main.sync {
                      self?.NetworkState = true

                  }
                  DispatchQueue.global(qos: .userInitiated).async {
                        self?.networkLayer.getDetaultPhotosList(completion: { result in
                            self?.photosList = try! result.get() ?? []
                        })
                    }
              }
              else{
                  DispatchQueue.main.sync {
                    //MARK: TO Change the backGround if there is no internet
                      self?.NetworkState = false
                      print(pathUpdateHandler.status)
                  }
              }
          }
          monitor.start(queue: queue)
    }
}
