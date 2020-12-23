//
//  swiftui_mvvmTests.swift
//  swiftui-mvvmTests
//
//  Created by Kilo Loco on 12/22/20.
//

import XCTest
@testable import swiftui_mvvm

class MockDataService: DataService {
    func getUsers(completion: @escaping ([User]) -> Void) {
        completion([User(id: 1, name: "Kilo Loco")])
    }
}

class swiftui_mvvmTests: XCTestCase {

    var sot: UsersView.ViewModel!
    
    override func setUpWithError() throws {
        sot = UsersView.ViewModel(dataService: MockDataService())
    }

    override func tearDownWithError() throws {
        sot = nil
    }
    
    func test_getUsers() throws {
        XCTAssertTrue(sot.users.isEmpty)
        
        sot.getUsers()
        
        XCTAssertEqual(sot.users.count, 1)
    }

}
