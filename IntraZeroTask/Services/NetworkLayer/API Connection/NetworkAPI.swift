//
//  NetworkAPI.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import Foundation
import Alamofire

protocol NetworkAPIProtocol {
    func changePage(page:String, completion: @escaping(Result<[Photo]?, NSError>) -> Void)
}
class NetworkAPI: BaseAPI<NetworkRequest>, NetworkAPIProtocol {
    static var networkApi =  NetworkAPI()

    func changePage(page: String, completion: @escaping (Result<[Photo]?, NSError>) -> Void) {
        self.fetchData(target: .changePage(page: page) , responseClass: [Photo].self){ (result) in
            completion(result)
        }
    }
    
   
    
    
   
    
}
