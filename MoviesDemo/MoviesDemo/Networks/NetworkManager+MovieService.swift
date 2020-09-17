//
//  NetworkManager+MovieService.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/18/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
import Moya

// MARK: - Movies Network Services
extension NetworkManager {
    func fetchMovies(page: Int,
                     sortBy: SortBy,
                     completion: @escaping ([Movie]?, Error?) -> Void) {
        provider.request(MultiTarget(MovieService.fetchMovies(page: page, sortBy: sortBy)),
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
        provider.request(MultiTarget(MovieService.fetchMovieDetail(movieId: movieId)),
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
