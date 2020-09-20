//
//  MovieTargetTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest

@testable import MoviesDemo
@testable import Moya

class MovieTargetTests: XCTestCase {
    var sut: MovieService!
    let translationLayer = JsonTranslationLayer()
    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() throws {
        let customEndpointClosure = { (target: MovieTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MovieTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        sut = MovieService(networkTranslationLayer: JsonTranslationLayer(), provider: stubbingProvider)
        
        sut.fetchMovies(page: 1, sortBy: .primaryReleaseDateAsc) { (movies, error) in
            XCTAssertNil(error)
            guard let strongMovies = movies else {
                XCTFail(TMessages.error)
                return
            }
            XCTAssertEqual(strongMovies.count, 2)
        }
    }

    func testFetchMoviesFailed() {
        let customEndpointClosure = { (target: MovieTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkError(TConstants.expectedError) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MovieTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        sut = MovieService(networkTranslationLayer: JsonTranslationLayer(), provider: stubbingProvider)
        
        sut.fetchMovies(page: 1, sortBy: .primaryReleaseDateAsc) { (movies, error) in
            XCTAssertNil(movies)
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchMovieDetailSuccess() {
        let customEndpointClosure = { (target: MovieTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MovieTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        sut = MovieService(networkTranslationLayer: JsonTranslationLayer(), provider: stubbingProvider)
        
        let movieID = 315946
        sut.fetchMovieDetail(movieId: movieID) { (movie, error) in
            XCTAssertNil(error)
            guard let strMovie = movie else {
                    XCTFail(TMessages.error)
                    return
            }
            XCTAssertEqual(strMovie.id, movieID)
        }
    }
    
    func testFetchMovieDetailFailed() {
        let customEndpointClosure = { (target: MovieTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkError(TConstants.expectedError) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MovieTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        sut = MovieService(networkTranslationLayer: JsonTranslationLayer(), provider: stubbingProvider)
        
        sut.fetchMovieDetail(movieId: -123) { (movie, error) in
            XCTAssertNil(movie)
            XCTAssertNotNil(error)
        }
    }
}
