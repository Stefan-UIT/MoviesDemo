//
//  MovieService.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
import Moya

enum MovieService {
    case fetchMovies(page: Int)
    case fetchMovieDetail(movieId: Int)
}

extension MovieService: TargetType {
    var path: String {
        switch self {
        case .fetchMovies:
            return Paths.fetchMovies
        case .fetchMovieDetail(let movieId):
            return String(format: Paths.fetchMovieDetail, movieId)
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any] {
        switch self {
        case .fetchMovies(let page):
            return [
                Keys.page: page,
                "api_key": "328c283cd27bd1877d9080ccb1604c91"
            ]
        case .fetchMovieDetail:
            return [
                "api_key": "328c283cd27bd1877d9080ccb1604c91"
            ]
        }
    }
    
    var task: Task {
        switch self {
        case .fetchMovies:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .fetchMovieDetail:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    // For unit test
    var sampleData: Data {
        return Data()
    }
}
