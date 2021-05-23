//
//  UsersAPIs.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 18/05/2021.
//

import Alamofire

enum UsersAPIs: URLRequestBuilder {
    case getUsers(Endpoint)
    case downloadImages(URL)
}

extension UsersAPIs {
    var baseURL: URL {
        switch self {
        case .getUsers(let endpoint):
            return endpoint.baseUrl
        case .downloadImages(let url):
            return url
        }
    }
    
    var path: String? {
        switch self {
        case .getUsers(let endpoint):
            return endpoint.path
        case .downloadImages:
            return nil
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getUsers(let endpoint):
            return endpoint.parameters
        case .downloadImages:
            return nil
        }
    }
}
