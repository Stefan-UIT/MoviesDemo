//
//  Movie.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

enum BasePosterUrl: String {
    case w185
    case w92
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

struct GeneralListResponse<T: Decodable>: Decodable {
    var page: Int
    var results: T?
}

struct Movie: Decodable {
    var title: String = ""
    var popularity: Double
    var posterPath: String?
    var backdropPath: String?
    var overview: String?
    
    var posterUrl: String? {
        guard let path = posterPath else { return nil }
        return BasePosterUrl.w92.baseURL + path
    }
    var popularityText: String {
        return "\(popularity)"
    }
}
