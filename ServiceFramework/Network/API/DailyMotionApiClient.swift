//
//  ApiClient.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire

struct DailyMotionApiClient: IApiClient {
    
    func fetchInfoAboutUsers(completion: @escaping (Result<[IUser]?, UserError>) -> Void) {
        sendRequest(url: Link.dailyMotionUrl, type: DailyMotionUsers.self) { result in
            switch result {
            case .success(let users):
                return completion(.success(users?.list))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}

