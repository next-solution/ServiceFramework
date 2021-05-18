//
//  User.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

protocol IUser: Codable {
    var username: String { get }
    var avatarUrl: String { get }
}
