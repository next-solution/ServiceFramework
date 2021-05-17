//
//  DailyMotionUsers.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

struct DailyMotionUsers: Codable, Error {
    let list: DailyMotionUser?
}

struct DailyMotionUser: Codable, Error {
    let avatar_360_url: String?
    let username: String?
}
