//
//  UITableViewExtensionsTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/20/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import MoviesDemo

class UITableViewExtensionsTests: XCTestCase {
    var sut: UITableView!

    override func setUpWithError() throws {
        super.setUp()
        sut = UITableView()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func testAddFooterLoadingSuccess() {
        sut.addFooterLoading()
        XCTAssertNotNil(sut.tableFooterView)
    }
    
    func testStopFooterLoadingSuccess() {
        testAddFooterLoadingSuccess()
        sut.stopFooterLoading()
        XCTAssertNil(sut.tableFooterView)
    }
}
