//
//  MovieService.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
import Moya

enum MovieTarget {
    case fetchMovies(page: Int, sortBy: SortBy)
    case fetchMovieDetail(movieId: Int)
}

extension MovieTarget: TargetType {
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
        case .fetchMovies(let page, let sortBy):
            return [
                sortBy.key: sortBy.value,
                Keys.page: page
            ]
        default:
            return [String: Any]()
        }
    }
    
    private var paramsWithAuth: [String: Any] {
        return parameters.merging(authParams) { (current, _) -> Any in
            current
        }
    }
    
    var task: Task {
        switch self {
        case .fetchMovies:
            return .requestParameters(parameters: paramsWithAuth, encoding: URLEncoding.default)
        case .fetchMovieDetail:
            return .requestParameters(parameters: paramsWithAuth, encoding: URLEncoding.default)
        }
    }
    
    // For unit test
    var sampleData: Data {
        switch self {
        case .fetchMovies:
            return SampleData.movies.data
        case .fetchMovieDetail:
            return SampleData.movieDetail.data
        }
    }
}
