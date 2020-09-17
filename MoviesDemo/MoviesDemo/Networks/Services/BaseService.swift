//
//  BaseService.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
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
