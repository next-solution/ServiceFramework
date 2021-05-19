//
//  URLRequestBuilder.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 18/05/2021.
//

import Alamofire

protocol URLRequestBuilder: URLRequestConvertible {
    var baseURL: URL { get }
    var requestURL: URL { get }
    var path: String? { get }
    var parameters: Parameters? { get }
    var urlRequest: URLRequest { get }
}

extension URLRequestBuilder {
    var requestURL: URL {
        if let path = path {
            return baseURL.appendingPathComponent(path, isDirectory: false)
        } else {
            return baseURL
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        return request
    }
    
    public func asURLRequest() throws -> URLRequest {
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
