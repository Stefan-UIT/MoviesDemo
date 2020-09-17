//
//  Constants+SampleData.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

enum SampleData {
    case movies
    case movieDetail
    
    var fileName: String {
        switch self {
        case .movies:
            return "Movies"
        case .movieDetail:
            return "MovieDetail"
        }
    }
    
    var data: Data {
        getData(filename: self.fileName)
    }
    
    func getData(filename fileName: String) -> Data {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error:\(error)")
            }
        }
        return Data()
    }
}
