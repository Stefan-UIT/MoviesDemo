//
//  NetworkManager.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
import Moya

enum JsonParseError: Error {
    case couldNotDecode
    
    var errorDescription: String {
        switch self {
        case .couldNotDecode:
            return Messages.couldNotDecode
        }
        
    }
}

protocol Translatable {
    func decode<T: Decodable>(_ type: T.Type, fromData data: Data) throws -> T
}

struct JsonTranslationLayer: Translatable {
    func decode<T: Decodable>(_ type: T.Type, fromData data: Data) throws -> T {
        guard let result: T = try? decoder.decode(type, from: data) else {
            throw JsonParseError.couldNotDecode }
        
        return result
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

class NetworkManager: Networkable {
    lazy var provider = MoyaProvider<MultiTarget>()
    let translationLayer: Translatable
    
    init(networkTranslationLayer: Translatable = JsonTranslationLayer()) {
        translationLayer = networkTranslationLayer
    }
}

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
