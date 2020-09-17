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

let realMovieID = 194079
let expectedError = NSError(domain: "domain", code: 404, userInfo: nil)
let movie1 = Movie(id: 1)
let movie2 = Movie(id: 2)

class NetworkableMock: Networkable {
    var provider = MoyaProvider<MultiTarget>()
    
    var isFetchMovieDetailSuccess: Bool!
    var isFetchMoviesSuccess: Bool!
    
    func fetchMovieDetail(movieId: Int, completion: @escaping (Movie?, Error?) -> Void) {
        if movieId == realMovieID {
            self.isFetchMovieDetailSuccess = true
        } else {
            self.isFetchMovieDetailSuccess = false
        }
    }
    
    func fetchMovies(page: Int, sortBy: SortBy, completion: @escaping ([Movie]?, Error?) -> Void) {
        if page > 0 {
            completion([movie1, movie2], nil)
        } else {
            completion(nil, expectedError)
            self.isFetchMoviesSuccess = false
        }
    }
}

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
}
