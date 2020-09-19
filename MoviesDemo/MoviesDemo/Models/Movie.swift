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
    private var popularity: Double?
    private var posterPath: String?
    private var backdropPath: String?
    private var runtime: Int?
    private var genres: [Genre]?
    private var spokenLanguages: [SpokenLanguage]?
    
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
    
    init(id: Int) {
        self.id = id
    }
}

struct Genre: Decodable {
    var id: Int
    var name: String = ""
}

struct SpokenLanguage: Decodable {
    var name: String = ""
}
