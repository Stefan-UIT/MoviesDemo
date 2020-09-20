//
//  MoviesViewModelTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/18/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest

@testable import MoviesDemo
@testable import Moya

class PagingCalculatorMock: PagingCalculable {
    var shouldLoadMore = false
    var isLastPage = false
    var currentPageAfterCalculating = 1
    
    func shouldLoadMoreItems(atRow row: Int,
                             numberOfItimes: Int,
                             isLastPageReached: Bool) -> Bool {
        shouldLoadMore
    }
    
    func isLastPageReached(numberOfNewItems: Int, dataPerPage: Int) -> Bool {
        isLastPage
    }
    
    func calculatingCurrentPage(_ currentPage: Int, isLastPage: Bool) -> Int {
        currentPageAfterCalculating
    }
}

class MoviesViewModelTests: XCTestCase {
    var sut: MoviesViewModel!
    var networkMock: MovieNetworkableMock!
    var delegateMock: MoviesViewModelDelegateMock!
    var pagingCalculatorMock: PagingCalculatorMock!

    override func setUpWithError() throws {
        super.setUp()
        networkMock = MovieNetworkableMock()
        delegateMock = MoviesViewModelDelegateMock()
        pagingCalculatorMock = PagingCalculatorMock()
        sut = MoviesViewModel(pagingCalculator: pagingCalculatorMock, provider: networkMock)
        sut.delegate = delegateMock
    }

    override func tearDownWithError() throws {
        sut = nil
        networkMock = nil
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() {
        sut.fetchMovies()

        XCTAssertGreaterThan(sut.numberOfItems, 0)
        XCTAssertEqual(sut.movie(at: 0).id, TConstants.movie1.id)
        XCTAssertEqual(sut.movie(at: 1).id, TConstants.movie2.id)
    }

    func testFetchMoviesSuccessIsResetFalse() {
        testFetchMoviesSuccess()

        sut.fetchMovies(isReset: false)
        XCTAssertEqual(sut.numberOfItems, 4)
    }

    func testFetchMovieDetailSuccessIsResetTrue() {
        testFetchMoviesSuccess()

        sut.fetchMovies(isReset: true)
        XCTAssertEqual(sut.numberOfItems, 2)
        XCTAssertEqual(sut.movie(at: 0).id, TConstants.movie1.id)
        XCTAssertEqual(sut.movie(at: 1).id, TConstants.movie2.id)
    }
    
    func testFetchMovieDetailFailed() throws {
        sut = MoviesViewModel(currentPage: -1, provider: networkMock)
        sut.fetchMovies()
        
        let isSuccess = try XCTUnwrap(networkMock.isFetchMoviesListSuccess)
        XCTAssertFalse(isSuccess)
    }

    func testGetMovieSuccess() {
        testFetchMoviesSuccess()
        let movie = sut.movie(at: 0)
        XCTAssertEqual(movie.id, TConstants.movie1.id)
    }

    func testGetNumberOfItems() {
        sut.fetchMovies()
        XCTAssertEqual(sut.numberOfItems, 2)
    }
    
    func testRefreshDataSuccess() {
        sut.fetchMovies()
        sut.fetchMovies()
        XCTAssertEqual(sut.numberOfItems, 4)
        
        sut.refreshData()
        XCTAssertEqual(sut.numberOfItems, 2)
    }
    
    func testRefreshDataFailed() throws {
        networkMock.isForceNetwokFailed = true
        pagingCalculatorMock.shouldLoadMore = true
        sut = MoviesViewModel(pagingCalculator: pagingCalculatorMock, provider: networkMock)
        sut.delegate = delegateMock
        sut.refreshData()
        
        let error = try XCTUnwrap(delegateMock.error)
        XCTAssertEqual(error as NSError, TConstants.expectedError)
    }
    
    // Delegates
    func testDidFinishFetchingDataDelegateIsCalled() {
        sut.fetchMovies()
        XCTAssertTrue(delegateMock.isDidFinishFetchingData)
    }
    
    func testDidLoadDataSuccessfullyDelegateIsCalled() {
        sut.fetchMovies()
        XCTAssertTrue(delegateMock.isDidLoadDataSuccessfully)
    }
    
    func testLoadingMoreItemsDelegateIsCalled() {
        pagingCalculatorMock.shouldLoadMore = true
        sut.loadMoreItemIfNeeded(atRow: 5)
        XCTAssertTrue(delegateMock.isLoadMoreItemCalled)
    }
    
    func testLoadingMoreItemsDelegateShouldNotBeCalled() {
        pagingCalculatorMock.shouldLoadMore = false
        sut.loadMoreItemIfNeeded(atRow: 5)
        XCTAssertFalse(delegateMock.isLoadMoreItemCalled)
    }
    
    func testDidFailWithErrorDelegateIsCalled() throws {
        networkMock.isForceNetwokFailed = true
        sut = MoviesViewModel(provider: networkMock)
        sut.delegate = delegateMock
        sut.fetchMovies()
        
        let error = try XCTUnwrap(delegateMock.error)
        XCTAssertEqual(error as NSError, TConstants.expectedError)
    }
}
