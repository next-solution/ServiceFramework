//
//  IApiClient.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

protocol IFetcher {
    func fetchInfoAboutUsers(completion: @escaping (Result<[IUser], UserError>) -> Void)
}
