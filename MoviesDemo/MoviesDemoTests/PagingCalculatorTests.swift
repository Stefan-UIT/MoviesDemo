//
//  PagingCalculatorTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import MoviesDemo

class PagingCalculatorTests: XCTestCase {
    var calculator: PagingCalculator!
    
    override func setUpWithError() throws {
        super.setUp()
        calculator = PagingCalculator()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testShouldLoadMoreItemsSuccess() {
        let result = calculator.shouldLoadMoreItems(atRow: 9, numberOfItimes: 10, isLastPageReached: false)
        XCTAssertTrue(result)
    }
    
    func testShouldLoadMoreItemsFalseDueToLastPageReached() {
        let result = calculator.shouldLoadMoreItems(atRow: 9, numberOfItimes: 10, isLastPageReached: true)
        XCTAssertFalse(result)
    }
    
    func testShouldLoadMoreItemsFalseDueToNearBottomItem() {
        let result = calculator.shouldLoadMoreItems(atRow: 1, numberOfItimes: 10, isLastPageReached: false)
        XCTAssertFalse(result)
    }
    
    func testIsLastPageReachedSuccess() {
        let result = calculator.isLastPageReached(numberOfNewItems: 9, dataPerPage: 10)
        XCTAssertTrue(result)
    }
    
    func testIsLastPageReachedFailed() {
        let result = calculator.isLastPageReached(numberOfNewItems: 15, dataPerPage: 10)
        XCTAssertFalse(result)
    }
    
    func testCalculatingCurrentPageIncrease() {
        let currentPage = 1
        let newCurrentPage = calculator.calculatingCurrentPage(currentPage, isLastPage: false)
        XCTAssertEqual(newCurrentPage, 2)
    }
    
    func testCalculatingCurrentPageNotIncrease() {
        let currentPage = 10
        let newCurrentPage = calculator.calculatingCurrentPage(currentPage, isLastPage: true)
        XCTAssertEqual(newCurrentPage, 10)
    }
}
