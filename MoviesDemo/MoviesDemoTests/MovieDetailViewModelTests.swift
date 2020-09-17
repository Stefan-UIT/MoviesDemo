//
//  MovieDetailViewModelTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest

@testable import MoviesDemo
@testable import Moya


class MovieDetailViewModelTests: XCTestCase {
    var viewModel: MovieDetailViewModel!
    var networkMock: NetworkableMock!
    
    override func setUpWithError() throws {
        super.setUp()
        networkMock = NetworkableMock()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        networkMock = nil
        super.tearDown()
    }
    
    func testFetchMovieDetailSuccess() {
        let movie = Movie(id: realMovieID)
        viewModel = MovieDetailViewModel(movie: movie, provider: networkMock)
        
        viewModel.fetchMovieDetail()
        XCTAssertTrue(networkMock.isFetchMovieDetailSuccess)
    }
    
    func testFetchMovieDetailFailed() {
        let movie = Movie(id: -1)
        viewModel = MovieDetailViewModel(movie: movie, provider: networkMock)
        
        viewModel.fetchMovieDetail()
        XCTAssertFalse(networkMock.isFetchMovieDetailSuccess)
    }
    
    func testDelegateMethodIsCalledAsync() {
        viewModel = MovieDetailViewModel(movie: realMovie, provider: networkMock)
        let delegateMock = MovieDetailViewModelDelegateMock()
        viewModel.delegate = delegateMock
        
        let expect = expectation(description: "Delegate calls the delegate as the result of an async method completion")
        delegateMock.asyncExpectation = expect
        
        viewModel.fetchMovieDetail()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            guard let result = delegateMock.delegateAsyncResult else {
                XCTFail("Expected delegate to be called")
                return
            }
            
            XCTAssertTrue(result)
        }
    }
    
    func testDelegateMethodIsCalledAsyncFailed() {
        viewModel = MovieDetailViewModel(movie: Movie(id: -1), provider: networkMock)
        let delegateMock = MovieDetailViewModelDelegateMock()
        viewModel.delegate = delegateMock
        
        let expect = expectation(description: "Delegate calls the delegate as the result of an async method completion")
        delegateMock.asyncExpectation = expect
        
        viewModel.fetchMovieDetail()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            guard let result = delegateMock.error else {
                XCTFail("Expected delegate to be called")
                return
            }
            
            XCTAssertEqual(result as NSError, expectedError)
        }
    }
}
