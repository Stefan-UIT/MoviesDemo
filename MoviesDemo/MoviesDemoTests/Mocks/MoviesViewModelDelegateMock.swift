//
//  MoviesViewModelDelegateMock.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/18/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import MoviesDemo

class  MoviesViewModelDelegateMock: MoviesViewModelDelegate {
    var didFinishFetchingData: Bool? = .none
    var didLoadData: Bool? = .none
    var didFinishFetchingDataAsyncExpectation: XCTestExpectation?
    var didLoadDataAsyncExpectation: XCTestExpectation?
    var asyncExpectation: XCTestExpectation?
    var error:Error?
    
    func didFinishFetchingData(in model: MoviesViewModel) {
        guard let expectation = didFinishFetchingDataAsyncExpectation else {
          XCTFail("Delegate was not setup correctly. Missing XCTExpectation reference")
          return
        }
        didFinishFetchingData = true
        expectation.fulfill()
    }
    
    func didLoadDataSuccessfully(in model: MoviesViewModel) {
        guard let expectation = didLoadDataAsyncExpectation else {
          XCTFail("Delegate was not setup correctly. Missing XCTExpectation reference")
          return
        }
        didFinishFetchingData = true
        expectation.fulfill()
    }
    
    func moviesViewModel(_ model: MoviesViewModel, didFailWithError error: Error) {
        guard let expectation = asyncExpectation else {
          XCTFail("Delegate was not setup correctly. Missing XCTExpectation reference")
          return
        }
        self.error = error
        expectation.fulfill()
    }
}
