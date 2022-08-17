//
//  DependencyProvider.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 17/08/2022.
//

import Foundation

struct DependencyProvider{
    
    static var networkAPIInstance : NetworkAPIProtocol {
        return NetworkAPI()
    }
    
  
    static var networkLayer : NetworkAPIProtocol {
        return NetworkAPI.networkApi
    }
    static var photoListViewModelInstance: PhotosListViewModel {
        return PhotosListViewModel(networkLayer: DependencyProvider.networkLayer)
    }
    
    static var photoDetailsViewModelInstance: PhotosDetailsViewModel {
        return PhotosDetailsViewModel()
    }
    
    static var networkManager : NetworkManager {
        return NetworkManager()
    }
    static var photoListViewInstance : PhotoListView {
        return PhotoListView(photoListVM: DependencyProvider.photoListViewModelInstance, photoDetailsVM: DependencyProvider.photoDetailsViewModelInstance, networkManager: DependencyProvider.networkManager)
    }
}
