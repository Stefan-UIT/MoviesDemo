//
//  Networkable.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
import Moya

protocol MovieNetworkable {
    var provider: MoyaProvider<MovieTarget> { get }

    func fetchMovies(page: Int, sortBy: SortBy, completion: @escaping ([Movie]?, Error?) -> Void)
    func fetchMovieDetail(movieId: Int, completion: @escaping (Movie?, Error?) -> Void)
}
