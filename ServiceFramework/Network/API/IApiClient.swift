//
//  IApiClient.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire
import AlamofireImage

protocol IApiClient {
    func fetchInfoAboutUsers(completion: @escaping (Result<[IUser]?, UserError>) -> Void)
}

extension IApiClient {
    var sessionManager: Session {
        get {
            let configuration = URLSessionConfiguration.af.default
            configuration.timeoutIntervalForRequest = 30
            configuration.waitsForConnectivity = true
            let networkLogger = ApiClientLogger()
            return Session(configuration: configuration, eventMonitors: [networkLogger])
        }
    }
    
    func sendRequest<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T?, UserError>) -> Void) {
        sessionManager.request(url, method: .get)
            .validate()
            .responseDecodable(of: T.self) { response in
                if let value = response.value {
                    completion(.success(value))
                } else if let error = response.error {
                    completion(.failure(UserError(description: error.errorDescription ?? "Unknown error")))
                } else {
                    completion(.success(nil))
                }
            }
    }
}
