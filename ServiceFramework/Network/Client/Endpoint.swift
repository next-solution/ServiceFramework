//
//  Endpoint.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 18/05/2021.
//

import Alamofire

enum Endpoint {
    case dailyMotion
    case gitHub
}

extension Endpoint {
    var baseUrl: URL {
        switch self {
        case .dailyMotion:
            return Link.dailyMotionUrl
        case .gitHub:
            return Link.gitHubUrl
        }
    }
    
    var path: String {
        return "users"
    }
    
    var parameters: Parameters? {
        switch self {
        case .dailyMotion:
            return ["fields": "avatar_360_url,username"]
        case .gitHub:
            return nil
        }
    }
}
