//
//  NetworkService.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 18/05/2021.
//

import Alamofire
import AlamofireImage

class NetworkService: NetworkServiceProtocol {
    
    let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        let networkLogger = NetworkServiceLogger()
        return Session(configuration: configuration, eventMonitors: [networkLogger])
    }()
}
