//
//  BaseUrlEnums.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

enum BasePosterUrl: String {
    case w92
    case w185
    case w300
    case original
    
    var baseURL: String {
        AppGateways.baseImageUrl + rawValue
    }
}

enum BaseBackdropUrl: String {
    case w300
    case w780
    case original
    
    var baseURL: String {
        AppGateways.baseImageUrl + rawValue
    }
}
