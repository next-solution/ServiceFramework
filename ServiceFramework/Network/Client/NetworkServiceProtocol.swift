//
//  NetworkServiceProtocol.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 20/05/2021.
//

import Alamofire

protocol NetworkServiceProtocol: class {
    func execute<T: Decodable>(_ urlRequest: URLRequestBuilder, model: T.Type, completion: @escaping (Result<T, AFError>) -> Void)
    func retrieveImage(_ urlRequest: URLRequestBuilder, completion: @escaping (Result<Data, AFError>) -> Void)
}
