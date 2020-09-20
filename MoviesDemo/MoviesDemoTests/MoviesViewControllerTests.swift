//
//  MoviesViewControllerTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/19/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import MoviesDemo

class MoviesViewControllerTests: XCTestCase {
    var sut: MoviesViewController!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = MoviesViewController.instantiate()
        sut.loadView()
        sut.viewDidLoad()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func testHasViewModel() {
        XCTAssertNotNil(sut.viewModel)
    }
}
