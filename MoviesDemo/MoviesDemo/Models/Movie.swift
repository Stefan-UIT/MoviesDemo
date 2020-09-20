//
//  Movie.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

struct GeneralListResponse<T: Decodable>: Decodable {
    var page: Int
    var results: T?
}

// swiftlint:disable identifier_name
struct Movie: Decodable {
    var id: Int
    var title: String = ""
    var overview: String = ""
    var popularity: Double?
    var posterPath: String?
    var backdropPath: String?
    var runtime: Int?
    var genres: [Genre]?
    var spokenLanguages: [SpokenLanguage]?
    
    var popularityText: String {
        guard let popNumber = popularity else { return "" }
        return "\(popNumber)"
    }
    
    var duration: String {
        guard let runtimeNumber = runtime else { return "" }
        return "\(runtimeNumber)"
    }
    
    var generNames: [String] {
        guard let array = genres, !array.isEmpty else { return [String]() }
        return array.map({ $0.name })
    }
    
    var generNamesWithDash: String {
        generNames.joined(separator: Separators.dashWithSpace)
    }
    
    var spokenLanguageNames: [String] {
        guard let array = spokenLanguages, !array.isEmpty else { return [String]() }
        return array.map({ $0.name })
    }
    
    var spokenLanguageNamesWithDash: String {
        spokenLanguageNames.joined(separator: Separators.dashWithSpace)
    }
    
    func posterUrl(basePosterUrl: BasePosterUrl = .w300) -> URL? {
        guard let path = posterPath else { return nil }
        return URL(string: basePosterUrl.baseURL + path)
    }
    
    func backdropUrl(baseBackdropUrl: BaseBackdropUrl = .w780) -> URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: baseBackdropUrl.baseURL + path)
    }
}

struct Genre: Decodable {
    var id: Int
    var name: String = ""
}

struct SpokenLanguage: Decodable {
    var name: String = ""
}
