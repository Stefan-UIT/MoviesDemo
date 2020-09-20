//
//  NetworkableMock.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/18/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//
import XCTest
@testable import MoviesDemo
@testable import Moya

class MovieNetworkableMock: MovieNetworkable {
    var provider = MoyaProvider<MovieTarget>()
    var isFetchMovieDetailSuccess: Bool? = .none
    var isFetchMoviesListSuccess: Bool? = .none
    var isForceNetwokFailed = false
        
    func fetchMovieDetail(movieId: Int, completion: @escaping (Movie?, Error?) -> Void) {
        let isSuccess = movieId == TConstants.movie1.id
        isFetchMovieDetailSuccess = isSuccess
        if isSuccess {
            completion(TConstants.movie1, nil)
        } else {
            completion(nil, TConstants.expectedError)
        }
    }
    
    func fetchMovies(page: Int, sortBy: SortBy, completion: @escaping ([Movie]?, Error?) -> Void) {
        if isForceNetwokFailed {
            completion(nil, TConstants.expectedError)
            return
        }
        
        let isSuccess = page > 0
        isFetchMoviesListSuccess = isSuccess
        if isSuccess {
            completion([TConstants.movie1, TConstants.movie2], nil)
        } else {
            completion(nil, TConstants.expectedError)
        }
    }
}
