//
//  ApiClient.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire

class ApiClient: IApiClient {
    
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = false
        
        let networkLogger = ApiClientLogger()
        
        
        return Session(configuration: configuration, eventMonitors: [networkLogger])
    }()
    
    
    func fetchInfoAboutDailyMotionUsers(completion: @escaping (Result<DailyMotionUsers?, DailyMotionError>?) -> Void) {
        sendRequest(url: Link.dailyMotionUrl, type: DailyMotionUsers.self) { result in
            completion(result)
        }
    }
    
    func fetchInfoAboutGithubUsers() { }
    
    private func sendRequest<T: Decodable>(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, type: T.Type, addAuthorization: Bool = true, completion: @escaping (Result<T?, DailyMotionError>?) -> Void) {
        sessionManager.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                guard
                    let statusCode = response.response?.statusCode else {
                    return completion(nil)
                }
                
                switch statusCode {
                case 400:
                    do {
                        if let data = response.data {
                            let decoder = JSONDecoder()
                            let error = try decoder.decode(DailyMotionError.self, from: data)
                            return completion(.failure(error))
                        }
                    } catch {
                        return completion(nil)
                    }
                case (200...204):
                    #if DEBUG
                    if let data = response.data {
                        do {
                            _ = try JSONDecoder().decode(T.self, from: data)
                        } catch {
                            print(error)
                        }
                    }
                    #endif
                    return completion(.success(response.value))
                default:
                    return completion(nil)
                }
            }
    }
    
}

