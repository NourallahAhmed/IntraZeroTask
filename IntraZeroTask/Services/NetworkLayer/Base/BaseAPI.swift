//
//  BaseAPI.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers)
            .validate()
            .responseDecodable(of: responseClass) { (response) in
              //  print(response.debugDescription)
                guard let statusCode = response.response?.statusCode else {
                    // Add custom error
                    print("Can't get status code")
//                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessages.genericError])
//                    completion(.failure(error))
                    
                    return
                }
                
                if statusCode == 200 {
                    // successful request
//                    print("---------url --------------")
//                    print("\(target.baseURL)+\(target.path)\(params.0)")
                    guard let response = try? response.result.get() else {
                        // Add custom error
                        print("Error while getting response")
//
//                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessages.genericError])
//                        completion(.failure(error))
                        return
                    }
                    
                    // return the result
                    print("\(responseClass) result returned successfully")
                    completion(.success(response))
                    
                } else {
                    
                    // Add custom error based on status code
                    print("Status code not successful 200")
                    print(response.debugDescription)
//                    let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: ErrorMessages.genericError])
//                    completion(.failure(error))
                    
                }
            }
    }

    
    func writeData<M: Any>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers)
            .validate()
            .responseJSON { (response) in
                print(response.debugDescription)

                guard let statusCode = response.response?.statusCode else {
                    // Add custom error
                    print("Can't get status code")
//                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessages.genericError])
//                    completion(.failure(error))
                    return
                }
                
                if statusCode >= 200 && statusCode < 300 {
                    
                    // successful request
                    guard let response = try? response.result.get() else {
                        
                        // Add custom error
                        print("Error while getting response")
//                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessages.genericError])
//                        completion(.failure(error))
                        return
                    }
                    
                    // return the result
                    print("\(responseClass) result returned successfully: \(response) tested")
                    completion(.success(response as? M))
                    
                } else {
                    
                    if statusCode == 422 { // handle error while posting
                        
                        print("Status code is 422")
//                        let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: ErrorMessages.statusCode422])
//                        completion(.failure(error))
                        
                    } else {
                        
                        // Add custom error based on status code
                        print("Status code not between 200 and 300")
//                        let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: ErrorMessages.genericError])
//                        completion(.failure(error))
                    }
                    
                }
            }
        
    }
    
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding){
        
        switch task {
        
        case .requestPlain:
            return ([:], URLEncoding.default)
            
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
        
    }
    
}
