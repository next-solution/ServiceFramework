//
//  NetworkServiceProtocol.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 20/05/2021.
//

import Alamofire

protocol NetworkServiceProtocol: class {
    var session: Session { get }
    
    func execute<T: Decodable>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, AFError>) -> Void)
    func retrieveImage(_ urlRequest: URLRequestBuilder, completion: @escaping (Result<Data, AFError>) -> Void)
}

extension NetworkServiceProtocol {
    
    func execute<T: Decodable>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, AFError>) -> Void) {
        session.request(urlRequest)
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
        session.request(urlRequest).responseImage { response in
            if let data = response.data {
                completion(.success(data))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
}
