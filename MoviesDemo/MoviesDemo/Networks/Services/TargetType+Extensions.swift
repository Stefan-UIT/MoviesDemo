//
//  BaseService.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

import Moya

public enum TheMovieDB {
  static let apiKey = "328c283cd27bd1877d9080ccb1604c91"
}

extension TargetType {
    var authParams: [String: Any] {
        [ Keys.apiKey: TheMovieDB.apiKey]
    }
    var baseURL: URL {
        return URL(string: AppGateways.baseApiUrl)!
    }
    
    var headers: [String: String]? {
        return [ Keys.contentType: Keys.applicationJson ]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
