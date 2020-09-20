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

class TranslableMock: Translatable {
    var isForceDecodeFailed = false
    
    init(isForceDecodeFailed: Bool) {
        self.isForceDecodeFailed = isForceDecodeFailed
    }
    
    func decode<T: Decodable>(_ type: T.Type, fromData data: Data) throws -> T {
        if isForceDecodeFailed {
            throw JsonParseError.couldNotDecode
        }
        
        return T.self as! T
    }
}

class MovieTargetTests: XCTestCase {
    var sut: MovieService!
    var translationLayer: Translatable!
    
    override func setUpWithError() throws {
        super.setUp()
        translationLayer = JsonTranslationLayer()
    }

    override func tearDownWithError() throws {
        sut = nil
        translationLayer = nil
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
        sut = MovieService(networkTranslationLayer: translationLayer, provider: stubbingProvider)
        
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
        
        sut = MovieService(networkTranslationLayer: translationLayer, provider: stubbingProvider)
        
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
        
        sut = MovieService(networkTranslationLayer: translationLayer, provider: stubbingProvider)
        
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
        
        sut = MovieService(networkTranslationLayer: translationLayer, provider: stubbingProvider)
        
        sut.fetchMovieDetail(movieId: -123) { (movie, error) in
            XCTAssertNil(movie)
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchMoviesSuccessButFailedParsingJson() throws {
        let customEndpointClosure = { (target: MovieTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MovieTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        translationLayer = TranslableMock(isForceDecodeFailed: true)
        sut = MovieService(networkTranslationLayer: translationLayer, provider: stubbingProvider)
        
        sut.fetchMovies(page: 1, sortBy: .primaryReleaseDateAsc) { (movies, error) in
            guard let jsonError = error as? JsonParseError else {
                XCTFail(TMessages.shouldBeNotDecodeable)
                return
            }
            XCTAssertEqual(jsonError, JsonParseError.couldNotDecode)
        }
    }
    
    func testFetchMovieDetailSuccessButFailedParsingJson() {
        let customEndpointClosure = { (target: MovieTarget) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MovieTarget>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        translationLayer = TranslableMock(isForceDecodeFailed: true)
        sut = MovieService(networkTranslationLayer: translationLayer, provider: stubbingProvider)
        
        let movieID = 315946
        sut.fetchMovieDetail(movieId: movieID) { (_, error) in
            guard let jsonError = error as? JsonParseError else {
                XCTFail(TMessages.shouldBeNotDecodeable)
                return
            }
            XCTAssertEqual(jsonError, JsonParseError.couldNotDecode)
        }
    }
}
