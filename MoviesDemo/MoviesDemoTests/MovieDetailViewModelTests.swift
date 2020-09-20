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
    var sut: MovieDetailViewModel!
    var networkMock: MovieNetworkableMock!
    
    override func setUpWithError() throws {
        super.setUp()
        networkMock = MovieNetworkableMock()
        sut = MovieDetailViewModel(movie: TConstants.movie1, provider: networkMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        networkMock = nil
        super.tearDown()
    }
    
    func testFetchMovieDetailSuccess() throws {
        sut.fetchMovieDetail()
        let isSuccess = try XCTUnwrap(networkMock.isFetchMovieDetailSuccess)
        XCTAssertTrue(isSuccess)
    }
    
    func testFetchMovieDetailFailed() throws {
        let movie = Movie(id: -1)
        sut = MovieDetailViewModel(movie: movie, provider: networkMock)
        
        sut.fetchMovieDetail()
        let isSuccess = try XCTUnwrap(networkMock.isFetchMovieDetailSuccess)
        XCTAssertFalse(isSuccess)
    }
    
    func testDelegateMethodIsCalledAsync() {
        let delegateMock = MovieDetailViewModelDelegateMock()
        sut.delegate = delegateMock
        
        let expect = expectation(description: TMessages.delegateGetCalling)
        delegateMock.asyncExpectation = expect
        
        sut.fetchMovieDetail()
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail(String(format: TMessages.timeOutWithError, error.localizedDescription))
            }
            
            guard let result = delegateMock.delegateAsyncResult else {
                XCTFail(TMessages.delegateWasNotCalled)
                return
            }
            
            XCTAssertTrue(result)
        }
    }
    
    func testDelegateMethodIsCalledAsyncFailed() {
        sut = MovieDetailViewModel(movie: Movie(id: -1), provider: networkMock)
        let delegateMock = MovieDetailViewModelDelegateMock()
        sut.delegate = delegateMock
        
        let expect = expectation(description: TMessages.delegateGetCalling)
        delegateMock.asyncExpectation = expect
        
        sut.fetchMovieDetail()
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail(String(format: TMessages.timeOutWithError, error.localizedDescription))
            }
            
            guard let result = delegateMock.error else {
                XCTFail(TMessages.delegateWasNotCalled)
                return
            }
            
            XCTAssertEqual(result as NSError, TConstants.expectedError)
        }
    }
    
    func testTitleIsCorrectValue() {
        XCTAssertEqual(sut.title, TConstants.movie1.title)
    }
    
    func testGenresIsCorrectValue() {
        XCTAssertNotNil(sut.genres.range(of: TConstants.movie1.generNamesWithDash))
    }
    
    func testLanguagesIsCorrectValue() {
        XCTAssertNotNil(sut.languages.range(of: TConstants.movie1.spokenLanguageNamesWithDash))
    }
    
    func testDurationIsCorrectValue() {
        XCTAssertNotNil(sut.duration.range(of: TConstants.movie1.duration))
    }
    
    func testOverviewIsCorrectValue() {
        XCTAssertNotNil(sut.overview.range(of: TConstants.movie1.overview))
    }
    
    func testBackdropUrlIsCorrectValue() {
        XCTAssertEqual(sut.backdropUrl, TConstants.movie1.backdropUrl())
    }
    
}
