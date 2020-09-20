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
    var asyncExpectation: XCTestExpectation?
    var isDidFinishFetchingData = false
    var isDidLoadDataSuccessfully = false
    var isLoadMoreItemCalled = false
    var error: Error?
    
    func didFinishFetchingData(in viewModel: MoviesViewModel) {
        isDidFinishFetchingData = true
    }
    
    func didLoadDataSuccessfully(in viewModel: MoviesViewModel) {
        isDidLoadDataSuccessfully = true
    }
    
    func moviesViewModel(_ viewModel: MoviesViewModel, didFailWithError error: Error) {
        self.error = error
    }
    
    func loadingMoreItems(in viewModel: MoviesViewModel) {
        isLoadMoreItemCalled = true
    }
}
