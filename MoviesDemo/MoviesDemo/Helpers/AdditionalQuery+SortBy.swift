//
//  AdditionalQuery+SortBy.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

enum SortBy: AdditionalQueryProtocol {
    case releaseDateAsc
    case releaseDateDesc
    case primaryReleaseDateAsc
    case primaryReleaseDateDesc
    
    var value: String {
        switch self {
        case .releaseDateAsc:
            return "release_date.asc"
        case .releaseDateDesc:
            return "release_date.desc"
        case .primaryReleaseDateAsc:
            return "primary_release_date.asc"
        case .primaryReleaseDateDesc:
            return "primary_release_date.desc"
        }
    }
    
    var key: String {
        return "sort_by"
    }
}
