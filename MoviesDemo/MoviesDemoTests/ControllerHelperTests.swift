//
//  ControllerHelperTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import MoviesDemo

class ControllerHelperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetRootViewSuccessful() {
        let expectedController = UIViewController()
        ControllerHelper.setToRootViewController(expectedController)
        let rootViewController = ControllerHelper.window?.rootViewController
        XCTAssertEqual(expectedController, rootViewController)
    }
}
