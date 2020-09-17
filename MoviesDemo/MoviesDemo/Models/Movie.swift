//
//  Movie.swift
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

struct GeneralListResponse<T: Decodable>: Decodable {
    var page: Int
    var results: T?
}

struct Movie: Decodable {
    private (set) var popularity: Double?
    private (set) var posterPath: String?
    private (set) var backdropPath: String?
    private (set) var runtime: Int?
    private (set) var genres: [Genre]?
    private (set) var spokenLanguages: [SpokenLanguage]?
    
    var id: Int
    var title: String = ""
    var overview: String = ""
    
    var posterUrl: String? {
        guard let path = posterPath else { return nil }
        return BasePosterUrl.w300.baseURL + path
    }
    
    var backdropUrl: String? {
        guard let path = backdropPath else { return nil }
        return BaseBackdropUrl.w780.baseURL + path
    }
    
    var popularityText: String {
        return "\(popularity ?? 0.0)"
    }
    
    var duration: String {
        return "\(runtime ?? 0)"
    }
    
    var generNames: String {
        guard let array = genres, !array.isEmpty else { return "" }
        let names = array.map({ $0.name })
        return names.joined(separator: " - ")

    }
    
    var spokenLanguageNames: String {
        guard let array = spokenLanguages, !array.isEmpty else { return "" }
        let names = array.map({ $0.name })
        return names.joined(separator: " - ")
    }
}

struct Genre: Decodable {
    var id: Int
    var name: String = ""
}

struct SpokenLanguage: Decodable {
    var name: String = ""
}
