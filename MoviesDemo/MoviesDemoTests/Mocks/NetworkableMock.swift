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

let realMovieID = 194079
let realMovie = Movie(id: realMovieID)
let expectedError = NSError(domain: "domain", code: 404, userInfo: nil)
let movie1 = Movie(id: 1)
let movie2 = Movie(id: 2)

class MovieNetworkableMock: MovieNetworkable {
    var provider = MoyaProvider<MovieTarget>()
    
    var isFetchMovieDetailSuccess: Bool!
    var isFetchMoviesSuccess: Bool!
    
    func fetchMovieDetail(movieId: Int, completion: @escaping (Movie?, Error?) -> Void) {
        if movieId == realMovieID {
            self.isFetchMovieDetailSuccess = true
            completion(movie1, nil)
        } else {
            self.isFetchMovieDetailSuccess = false
            completion(nil, expectedError)
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
