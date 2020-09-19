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

class MoviesViewModelTests: XCTestCase {
    var viewModel: MoviesViewModel!
    var networkMock: MovieNetworkableMock!
    
    override func setUpWithError() throws {
        super.setUp()
        networkMock = MovieNetworkableMock()
        viewModel = MoviesViewModel(provider: networkMock)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        networkMock = nil
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() {
        viewModel.currentPage = 1
        viewModel.fetchMovies()
        
        XCTAssertGreaterThan(viewModel.numberOfItems, 0)
        XCTAssertEqual(viewModel.movie(at: 0).id, movie1.id)
        XCTAssertEqual(viewModel.movie(at: 1).id, movie2.id)
    }
    
    func testFetchMoviesSuccessIsResetFalse() {
        testFetchMoviesSuccess()
        
        viewModel.fetchMovies(isReset: false)
        XCTAssertEqual(viewModel.numberOfItems, 4)
    }
    
    func testFetchMovieDetailSuccessIsResetTrue() {
        testFetchMoviesSuccess()
        
        viewModel.fetchMovies(isReset: true)
        XCTAssertEqual(viewModel.numberOfItems, 2)
    }
    
    func testFetchMovieDetailFailed() {
        viewModel.currentPage = -1
        viewModel.fetchMovies()
        
        XCTAssertFalse(networkMock.isFetchMoviesSuccess)
    }
    
    func testRefreshDataSuccess() {
        viewModel.currentPage = 999
        viewModel.refreshData()
        
        XCTAssertEqual(viewModel.currentPage, 1)
    }
    
    func testGetMovieSuccess() {
        testFetchMoviesSuccess()
        let movie = viewModel.movie(at: 0)
        XCTAssertEqual(movie.id, movie1.id)
    }
    
    func testGetNumberOfItems() {
        viewModel.fetchMovies(isReset: true)
        XCTAssertEqual(viewModel.numberOfItems, 2)
    }
}
