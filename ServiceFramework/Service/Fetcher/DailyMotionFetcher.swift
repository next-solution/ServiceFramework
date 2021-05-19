//
//  DailyMotionFetcher.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire

public class DailyMotionFetcher: IFetcher {
    
    public static let `default` = DailyMotionFetcher()
    
    public func fetchInfoAboutUsers(completion: @escaping (Result<[IUser], UserError>) -> Void) {
        networkService.execute(UsersAPIs.getUsers(.dailyMotion), model: DailyMotionUsers.self) { result in
            switch result {
            case .success(let users):
                return completion(.success(users.list))
            case .failure(let error):
                let errorDescription = error.errorDescription ?? "Unknown error"
                return completion(.failure(UserError(description: errorDescription)))
            }
        }
    }
}

