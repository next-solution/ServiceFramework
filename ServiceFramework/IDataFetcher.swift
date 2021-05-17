//
//  IDataFetcher.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

protocol IDataFetcher {
    func fetchUserData() -> [UserData]
}
