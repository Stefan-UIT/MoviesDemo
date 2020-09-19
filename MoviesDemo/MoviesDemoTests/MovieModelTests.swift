//
//  MovieModelTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/19/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import MoviesDemo

class MovieModelTests: XCTestCase {
    var movie: Movie!
    let invalidPath = "Invalid path"
    override func setUpWithError() throws {
        super.setUp()
        movie = Movie(id: 1)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testPosterURLIsNil() {
        movie.posterPath = nil
        XCTAssertNil(movie.posterUrl())
    }
    
    func testInvalidPosterURL() {
        movie.posterPath = invalidPath
        XCTAssertNil(movie.posterUrl())
    }
    
    func testValidPosterURL() {
        let validPath = "/XWPDZzK7N2WQcejI8W96IxZEeP.jpg"
        movie.posterPath = validPath
        let result = movie.posterUrl(basePosterUrl: .w300)
        XCTAssertNotNil(result)
        XCTAssertNotNil(result?.absoluteString.range(of: validPath))
        XCTAssertNotNil(result?.absoluteString.range(of: BasePosterUrl.w300.baseURL))
    }
    
    func testBackdropURLIsNil() {
        movie.backdropPath = nil
        XCTAssertNil(movie.backdropUrl())
    }
    
    func testInvalidBackdropURL() {
        movie.backdropPath = invalidPath
        XCTAssertNil(movie.backdropUrl())
    }
    
    func testValidBackdropURL() throws {
        let validPath = "/d5O93YRHzzFTYv7B8DreUFDYd8t.jpg"
        movie.backdropPath = validPath
        let result = try XCTUnwrap(movie.backdropUrl(baseBackdropUrl: .w780))
        XCTAssertNotNil(result.absoluteString.range(of: validPath))
        XCTAssertNotNil(result.absoluteString.range(of: BaseBackdropUrl.w780.baseURL))
    }
    
    func testPopularityTextIsNil() {
        movie.popularity = nil
        XCTAssertTrue(movie.popularityText.isEmpty)
    }
    
    func testPopularityTextIsValid() {
        movie.popularity = 123.8
        XCTAssertEqual(movie.popularityText, "123.8")
    }
    
    func testDurationIsNoValue() {
        movie.runtime = nil
        XCTAssertTrue(movie.duration.isEmpty)
    }
    
    func testDurationIsValid() {
        movie.runtime = 1
        XCTAssertEqual(movie.duration, "1")
    }
    
    func testGenresIsNoValue() {
        movie.genres = nil
        XCTAssertTrue(movie.generNames.isEmpty)
        XCTAssertTrue(movie.generNamesWithDash.isEmpty)
    }
    
    func testGenresIsEmpty() {
        movie.genres = [Genre]()
        XCTAssertTrue(movie.generNames.isEmpty)
        XCTAssertTrue(movie.generNamesWithDash.isEmpty)
    }
    
    func testGenresIsValidWithOneElement() throws {
        let expectedName = "Anime"
        let gen1 = Genre(id: 1, name: expectedName)
        movie.genres = [gen1]
        let genreName = try XCTUnwrap(movie.generNames.first)
        XCTAssertEqual(genreName, expectedName)
        XCTAssertEqual(movie.generNamesWithDash, expectedName)
    }
    
    func testGenresIsValidWithMoreThanOneElement() throws {
        let gen1 = Genre(id: 1, name: "name1")
        let gen2 = Genre(id: 2, name: "name2")
        movie.genres = [gen1, gen2]
        XCTAssertEqual(movie.generNames.count, 2)
        XCTAssertNotNil(movie.generNamesWithDash.range(of: gen1.name))
        XCTAssertNotNil(movie.generNamesWithDash.range(of: gen2.name))
    }
    
    func testSpokenLanguagesIsNoValue() {
        movie.spokenLanguages = nil
        XCTAssertTrue(movie.spokenLanguageNames.isEmpty)
        XCTAssertTrue(movie.spokenLanguageNamesWithDash.isEmpty)
    }
    
    func testSpokenLanguagesIsEmpty() {
        movie.spokenLanguages = [SpokenLanguage]()
        XCTAssertTrue(movie.spokenLanguageNames.isEmpty)
        XCTAssertTrue(movie.spokenLanguageNamesWithDash.isEmpty)
    }
    
    func testSpokenLanguagesIsValidWithOneElement() throws {
        let expectedName = "Vietnamese"
        let language1 = SpokenLanguage(name: expectedName)
        movie.spokenLanguages = [language1]
        let name = try XCTUnwrap(movie.spokenLanguageNames.first)
        XCTAssertEqual(name, expectedName)
        XCTAssertEqual(movie.spokenLanguageNamesWithDash, expectedName)
    }
    
    func testSpokenLanguagesIsValidWithMoreThanOneElement() throws {
        let language1 = SpokenLanguage(name: "Vietnamese")
        let language2 = SpokenLanguage(name: "English")
        movie.spokenLanguages = [language1, language2]
        XCTAssertEqual(movie.spokenLanguageNames.count, 2)
        XCTAssertNotNil(movie.spokenLanguageNamesWithDash.range(of: language1.name))
        XCTAssertNotNil(movie.spokenLanguageNamesWithDash.range(of: language2.name))
    }
}
