//
//  TestableConstants.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/20/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation
@testable import MoviesDemo

struct TConstants {
    static let movie1 = Movie(id: 1, title: "movie 1", overview: "overview 1", popularity: 1.1, posterPath: "/nOK6mVgBUkt7IVSfesVVJd4i5uU.jpg", backdropPath: "/nOK6mVgBUkt7IVSfesVVJd4i5uU.jpg", runtime: 1, genres: [gener1], spokenLanguages: [language1])
    static let movie2 = Movie(id: 2, title: "movie 2", overview: "overview 2", popularity: 2.2, runtime: 2)
    static let expectedError = NSError(domain: "domain", code: 404, userInfo: nil)
    
    static let gener1 = Genre(id: 1, name: "Gene 1")
    static let language1 = SpokenLanguage(name: "Language 1")
}

struct TMessages {
    static let delegateWasNotCalled = "Delegate was not called"
    static let delegateGetCalling = "Delegate get calling"
    static let timeOutWithError = "Time out errored: %@"
    static let delegateWasNotSetUpCorrect = "Delegate was not setup correctly"
    static let error = "Error"
    static let shouldBeNotDecodeable = "Should Be Not Decodeable"
    static let invalidPath = "Invalid path"
}
