//
//  NetworkRequest.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import Foundation
import Alamofire

enum NetworkRequest{
    case getDefaultPhotos
    case updatedPhotosList( limit : String)
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
       
        case .getDefaultPhotos:
            return "page=1&limit=10"
          
        case.updatedPhotosList(let limit):
            return "limit=\(limit)"
            
        case.changePage(let page):
              return "page=\(page)&limit=20"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getDefaultPhotos:
                return .get
            case .updatedPhotosList:
                return .get
        case .changePage:
              return  .get
        }
    }
    
    var task: Task {
        switch self {
            
        case .getDefaultPhotos:
            return .requestPlain
        case .updatedPhotosList:
            return .requestPlain
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
