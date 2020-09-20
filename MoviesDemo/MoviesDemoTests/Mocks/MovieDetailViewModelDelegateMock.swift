//
//  MovieDetailViewModelDelegateMock.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/18/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//
import XCTest
@testable import MoviesDemo

class  MovieDetailViewModelDelegateMock: MovieDetailViewModelDelegate {
    var delegateAsyncResult: Bool? = .none
    var asyncExpectation: XCTestExpectation?
    var error: Error?
    
    func didLoadDataSuccessfully(in model: MovieDetailViewModel) {
        guard let expectation = asyncExpectation else {
          XCTFail(TMessages.delegateWasNotSetUpCorrect)
          return
        }
        delegateAsyncResult = true
        expectation.fulfill()

    }
    func movieDetailViewModel(_ model: MovieDetailViewModel, didFailWithError error: Error) {
        guard let expectation = asyncExpectation else {
          XCTFail(TMessages.delegateWasNotSetUpCorrect)
          return
        }
        self.error = error
        expectation.fulfill()
    }
}
