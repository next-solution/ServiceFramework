//
//  NetworkService.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 18/05/2021.
//

import Alamofire
import AlamofireImage

protocol NetworkServiceProtocol: class {
    func execute<T: Decodable>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, AFError>) -> Void)
    func retrieveImage(_ urlRequest: URLRequestBuilder, completion: @escaping (Result<Data, AFError>) -> Void)
}

extension NetworkServiceProtocol {
    var sessionManager: Session {
        get {
            let configuration = URLSessionConfiguration.af.default
            configuration.timeoutIntervalForRequest = 30
            configuration.waitsForConnectivity = true
            let networkLogger = NetworkServiceLogger()
            return Session(configuration: configuration, eventMonitors: [networkLogger])
        }
    }
    
    func execute<T: Decodable>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, AFError>) -> Void) {
        sessionManager.request(urlRequest)
            .validate()
            .responseDecodable(of: T.self) { response in
                if let value = response.value {
                    completion(.success(value))
                } else if let error = response.error {
                    completion(.failure(error))
                }
            }
    }
    
    func retrieveImage(_ urlRequest: URLRequestBuilder, completion: @escaping (Result<Data, AFError>) -> Void) {
        sessionManager.request(urlRequest).responseImage { response in
            if let data = response.data {
                completion(.success(data))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
}

class NetworkService: NetworkServiceProtocol {
    public static let `default`: NetworkServiceProtocol = {
        var service = NetworkService()
        return service
    }()
}
