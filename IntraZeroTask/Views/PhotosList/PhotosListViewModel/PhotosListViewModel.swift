//
//  PhotosListViewModel.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import Foundation
import Network
import CoreData

protocol photosListProtocol {
    func changePage(page:String)
}
class PhotosListViewModel : ObservableObject , photosListProtocol {

    @Published var photosList : [Photo] = [Photo] ()
    @Published var photosListGrouped = [[Photo]]()
    @Published var photoLoaded = false

    
    //MARK: Network
    var networkLayer  : NetworkAPIProtocol
    init(networkLayer : NetworkAPIProtocol) {
        self.networkLayer = networkLayer
    }
   
    func changePage(page: String) {
        self.photoLoaded = false
        DispatchQueue.global(qos: .userInitiated).async {
            self.networkLayer.changePage(page: page ,completion: { result in
                DispatchQueue.main.async {
                    guard let photos = try? result.get() else{
                        return
                    }
                    self.photosList = photos
                    self.photosListGrouped =  self.photosList.dividedIntoGroups(of: 5)
                    self.photoLoaded = true
                }
            })
        }
    }
    
  
}
