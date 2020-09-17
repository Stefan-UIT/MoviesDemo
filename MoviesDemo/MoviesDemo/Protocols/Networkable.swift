//
//  Networkable.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<MultiTarget> { get }
    
    func fetchMovies(page: Int, completion: @escaping ([Movie]?, Error?) -> Void)
}
