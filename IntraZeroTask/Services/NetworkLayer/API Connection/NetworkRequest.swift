//
//  NetworkRequest.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import Foundation
import Alamofire

enum NetworkRequest{
    case changePage(page:String)
}

extension NetworkRequest : TargetType {
    var baseURL: String {
        switch self {
                 default : return "https://picsum.photos/v2/list?"
        }
    }
    
    var path: String {
        switch self {
            
        case.changePage(let page):
              return "page=\(page)&limit=10"
        }
    }
    
    var method: HTTPMethod {
        switch self {

        case .changePage:
              return  .get
        }
    }
    
    var task: Task {
        switch self {
        case .changePage:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:

            return nil
        }
    }
}
