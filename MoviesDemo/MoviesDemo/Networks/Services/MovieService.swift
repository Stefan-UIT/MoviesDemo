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
}

extension MovieService: TargetType {
    var path: String {
        switch self {
        case .fetchMovies:
            return Paths.fetchMovies
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMovies:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .fetchMovies(let page):
            return [
                Keys.page: page,
                "api_key": "328c283cd27bd1877d9080ccb1604c91"
            ]
        }
    }
    
    var task: Task {
        switch self {
        case .fetchMovies:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    // For unit test
    var sampleData: Data {
        return Data()
    }
}
