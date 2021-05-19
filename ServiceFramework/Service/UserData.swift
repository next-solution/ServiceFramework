//
//  UserData.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

public struct UserData {
    public let serviceType: ServiceType
    public let name: String
    public var avatar: Data?
    
    public init(serviceType: ServiceType, name: String, avatar: Data?) {
        self.serviceType = serviceType
        self.name = name
        self.avatar = avatar
    }
}
