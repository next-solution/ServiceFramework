//
//  NetworkServiceLogger.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire

class NetworkServiceLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "service.networklogger")
    
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else { return }
        if let json = try? JSONSerialization
            .jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}
