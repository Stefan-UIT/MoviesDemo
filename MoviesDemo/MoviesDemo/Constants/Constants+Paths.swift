//
//  Constants+Paths.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

struct AppGateways {
    static let baseApiUrl = "https://api.themoviedb.org/3"
    static let baseImageUrl = "https://image.tmdb.org/t/p/"
}

struct Paths {
    static let fetchMovies = "/discover/movie"
    static let fetchMovieDetail = "/movie/%d"
    static let dataPerPage = 20
}

struct Keys {
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
    static let main = "Main"
    static let page = "page"
}
