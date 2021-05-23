//
//  ServiceFrameworkTests.swift
//  ServiceFrameworkTests
//
//  Created by Marcin Makurat on 17/05/2021.
//

import XCTest
import Mocker
import Swinject
import Alamofire

@testable import ServiceFramework

class NetworkTests: XCTestCase {
    
    var networkService: NetworkServiceMock?
    
    override func setUpWithError() throws {
        networkService = Assembler.default.resolver.resolve(NetworkServiceProtocol.self, name: "NetworkServiceMock") as? NetworkServiceMock
        
        let session: Session = {
            let configuration = URLSessionConfiguration.af.default
            configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
            configuration.timeoutIntervalForRequest = 30
            configuration.waitsForConnectivity = true
            let networkLogger = NetworkServiceLogger()
            return Session(configuration: configuration, eventMonitors: [networkLogger])
        }()
        
        networkService?.session = session
    }
    
    func testDailyMotionFetching() throws {
        
        let apiEndpoint = URL(string: "https://api.dailymotion.com/users?fields=avatar_360_url%2Cusername")!
        let expectedUsers = DailyMotionUsers(list: [
            DailyMotionUser(username: "Frodo Bagins", avatarUrl: "https://get.images.com"),
            DailyMotionUser(username: "Gandalf Grey", avatarUrl: "https://get.images.com/dksajkdsa?dkjdsa")
        ])
        
        if let mockedData = try? JSONEncoder().encode(expectedUsers) {
            let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
            mock.register()
        }
        
        let requestExpectation = expectation(description: "Request should finish")
        
        networkService?.execute(UsersAPIs.getUsers(.dailyMotion), model: DailyMotionUsers.self) { result in
            defer { requestExpectation.fulfill() }
            
            switch result {
            case .success(let value):
                XCTAssertEqual(value, expectedUsers)
            case .failure(let error):
                XCTFail("Expected to be a success but got a failue with \(error)")
            }
        }
        wait(for: [requestExpectation], timeout: 10.0)
    }
    
    func testGitHubUserFetching() throws {
        let apiEndpoint = UsersAPIs.getUsers(.gitHub).requestURL
        let expectedUsers = [
            GithubUser(username: "Frodo Bagins", avatarUrl: "https://get.images.com"),
            GithubUser(username: "Gandalf Grey", avatarUrl: "https://get.images.com/dksajkdsa?dkjdsa")
        ]
        
        if let mockedData = try? JSONEncoder().encode(expectedUsers) {
            let mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: mockedData])
            mock.register()
        }
        
        let requestExpectation = expectation(description: "Request should finish")
        
        networkService?.execute(UsersAPIs.getUsers(.gitHub), model: [GithubUser].self) { result in
            defer { requestExpectation.fulfill() }
            
            switch result {
            case .success(let value):
                XCTAssertEqual(value, expectedUsers)
            case .failure(let error):
                XCTFail("Expected to be a success but got a failue with \(error)")
            }
        }
        wait(for: [requestExpectation], timeout: 10.0)
    }
}
