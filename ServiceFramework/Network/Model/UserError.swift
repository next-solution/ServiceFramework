//
//  UserError.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Foundation

public struct UserError: Error {
    public let description: String
    
    init (description: String) {
        self.description = description
    }
}
