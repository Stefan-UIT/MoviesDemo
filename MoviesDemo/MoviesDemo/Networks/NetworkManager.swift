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
    lazy var provider = MoyaProvider<MovieTarget>()
    let translationLayer: Translatable
    
    init(networkTranslationLayer: Translatable = JsonTranslationLayer()) {
        translationLayer = networkTranslationLayer
    }
}
