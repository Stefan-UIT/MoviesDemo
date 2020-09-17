//
//  JsonTranslationLayer.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/18/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

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
