//
//  BaseViewModel.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

class BaseMovieViewModel {
    var provider: MovieNetworkable!
    
    init(provider: MovieNetworkable = MovieService()) {
        self.provider = provider
    }
}
