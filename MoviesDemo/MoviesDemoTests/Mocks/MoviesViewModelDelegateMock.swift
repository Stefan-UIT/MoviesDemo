//
//  MoviesViewModelDelegateMock.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/18/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import MoviesDemo

struct Messages {
    static let delegateWasNotSetUpCorrect = "Delegate was not setup correctly"
}

class  MoviesViewModelDelegateMock: MoviesViewModelDelegate {
    var asyncExpectation: XCTestExpectation?
    var delegateAsyncResult: Bool? = .none
    var error: Error?
    
    func didFinishFetchingData(in model: MoviesViewModel) {
        guard let expectation = asyncExpectation else {
            XCTFail(Messages.delegateWasNotSetUpCorrect)
          return
        }
        delegateAsyncResult = true
        expectation.fulfill()
    }
    
    func didLoadDataSuccessfully(in model: MoviesViewModel) {
        guard let expectation = asyncExpectation else {
          XCTFail(Messages.delegateWasNotSetUpCorrect)
          return
        }
        delegateAsyncResult = true
        expectation.fulfill()
    }
    
    func moviesViewModel(_ model: MoviesViewModel, didFailWithError error: Error) {
        guard let expectation = asyncExpectation else {
          XCTFail(Messages.delegateWasNotSetUpCorrect)
          return
        }
        self.error = error
        expectation.fulfill()
    }
    
    func resetData() {
        asyncExpectation = nil
        delegateAsyncResult = .none
        error = nil
    }
}
