//
//  NetworkManager.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
import Moya

class MovieService: MovieNetworkable {
    var provider = MoyaProvider<MovieTarget>()
    let translationLayer: Translatable
    
    init(networkTranslationLayer: Translatable = JsonTranslationLayer(),
         provider: MoyaProvider<MovieTarget> = MoyaProvider<MovieTarget>()) {
        self.translationLayer = networkTranslationLayer
        self.provider = provider
    }
}

// MARK: - Movies Network Services
extension MovieService {
    func fetchMovies(page: Int,
                     sortBy: SortBy,
                     completion: @escaping ([Movie]?, Error?) -> Void) {
        provider.request(MovieTarget.fetchMovies(page: page, sortBy: sortBy),
                         completion: { (response) in
                            switch response {
                            case .failure(let error):
                                completion(nil, error)
                            case .success(let response):
                                do {
                                    let decodedData = try self.translationLayer.decode(GeneralListResponse<[Movie]>.self, fromData: response.data)
                                    completion(decodedData.results, nil)
                                } catch let error {
                                    completion(nil, error)
                                }
                            }
        })
    }
    
    func fetchMovieDetail(movieId: Int,
                          completion: @escaping (Movie?, Error?) -> Void) {
        provider.request(MovieTarget.fetchMovieDetail(movieId: movieId),
                         completion: { (response) in
                            switch response {
                            case .failure(let error):
                                completion(nil, error)
                            case .success(let response):
                                do {
                                    let decodedData = try self.translationLayer.decode(Movie.self, fromData: response.data)
                                    completion(decodedData, nil)
                                } catch let error {
                                    completion(nil, error)
                                }
                            }
        })
    }
}
