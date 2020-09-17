//
//  MovieServiceTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest

@testable import MoviesDemo
@testable import Moya

class MovieServiceTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testFetchMoviesSuccess() {
        let customEndpointClosure = { (target: MovieService) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MovieService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        stubbingProvider.request(.fetchMovies(page: 1, sortBy: .releaseDateAsc)) { (response) in
            switch response {
            case .failure(_):
                XCTFail("Error")
            case .success(let response):
                let expectedData = MovieService.fetchMovies(page: 1, sortBy: .releaseDateAsc).sampleData
                XCTAssertEqual(response.data, expectedData)
            }
        }
    }
    
    func testFetchMoviesFailed() {
        let expectedError = NSError(domain: "domain", code: 404, userInfo: nil)
        
        let customEndpointClosure = { (target: MovieService) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkError(expectedError) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MovieService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        stubbingProvider.request(.fetchMovies(page: -1, sortBy: .releaseDateAsc)) { (response) in
            switch response {
            case .failure(let error):
                guard let nsError = error.underlyingError as NSError? else {
                    XCTFail("Wrong Error")
                    return
                }
                XCTAssertEqual(nsError.code, expectedError.code)
            case .success(_):
                XCTFail("the request should be failed")
            }
        }
    }
    
    func testFetchMovieDetailSuccess() {
        let customEndpointClosure = { (target: MovieService) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MovieService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        stubbingProvider.request(.fetchMovieDetail(movieId: 315946)) { (response) in
            switch response {
            case .failure(_):
                XCTFail("Error")
            case .success(let response):
                let expectedData = MovieService.fetchMovieDetail(movieId: 315946).sampleData
                XCTAssertEqual(response.data, expectedData)
            }
        }
    }
    
    func testFetchMovieDetailFailed() {
        let expectedError = NSError(domain: "domain", code: 404, userInfo: nil)
        
        let customEndpointClosure = { (target: MovieService) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkError(expectedError) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let stubbingProvider = MoyaProvider<MovieService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        
        stubbingProvider.request(.fetchMovieDetail(movieId: -123)) { (response) in
            switch response {
            case .failure(let error):
                guard let nsError = error.underlyingError as NSError? else {
                    XCTFail("Wrong Error")
                    return
                }
                XCTAssertEqual(nsError.code, expectedError.code)
            case .success(_):
                XCTFail("the request should be failed")
            }
        }
    }
}
