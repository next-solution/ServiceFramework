//
//  NetworkServiceMock.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 23/05/2021.
//

import Alamofire

class NetworkServiceMock: NetworkServiceProtocol {
    
    var session: Session = {
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration)
    }()
    
}
