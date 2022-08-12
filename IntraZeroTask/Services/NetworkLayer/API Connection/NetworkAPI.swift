//
//  NetworkAPI.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import Foundation
import Alamofire

protocol NetworkAPIProtocol {
//    func loginCustomer(completion: @escaping(Result<CustomersResponse?, NSError>) -> Void)
    func getDetaultPhotosList(completion: @escaping(Result<[Photo]?, NSError>) -> Void)
}
class NetworkAPI: BaseAPI<NetworkRequest>, NetworkAPIProtocol {
    static var networkApi =  NetworkAPI()
    
    func getDetaultPhotosList(completion: @escaping (Result<[Photo]?, NSError>) -> Void) {
        self.fetchData(target: .getDefaultPhotos , responseClass: [Photo].self){ (result) in
                   completion(result)
               }
    }
    
    
    
   
    
}
