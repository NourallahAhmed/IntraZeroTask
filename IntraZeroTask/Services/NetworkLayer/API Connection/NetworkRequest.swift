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
    
}

extension NetworkRequest : TargetType {
    var baseURL: String {
        switch self {
                 default : return "https://picsum.photos/v2/list?page=1&limit=20"
        }
    }
    
    var path: String {
        switch self {
       
        case .getDefaultPhotos:
            return ""
          
        case.updatedPhotosList(let limit):
            return ""

        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getDefaultPhotos:
                return .get
            case .updatedPhotosList(limit: let limit):
                return .get
        }
    }
    
    var task: Task {
        switch self {
            
        case .getDefaultPhotos:
            return .requestPlain
        case .updatedPhotosList(limit: let limit):
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
