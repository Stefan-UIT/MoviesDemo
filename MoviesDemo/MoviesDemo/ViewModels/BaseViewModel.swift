//
//  BaseViewModel.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

class BaseViewModel {
    var provider: Networkable!
    
    init(provider: Networkable = NetworkManager()) {
        self.provider = provider
    }
}
