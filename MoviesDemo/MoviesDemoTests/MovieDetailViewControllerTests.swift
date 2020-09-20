//
//  MovieDetailViewControllerTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/19/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest

@testable import MoviesDemo

class MovieDetailViewControllerTests: XCTestCase {
    var sut: MovieDetailViewController!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = MovieDetailViewController.instantiate()
        sut.loadView()
        sut.viewDidLoad()
        sut.movie = Test.movie1
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testHasAnOverViewLabel() {
        XCTAssertNotNil(sut.overviewLabel)
    }
    
    func testHasADurationLabel() {
        XCTAssertNotNil(sut.durationLabel)
    }
    
    func testHasAHasAnLanguagesLabel() {
        XCTAssertNotNil(sut.languagesLabel)
    }
    
    func testHasAGenresLabel() {
        XCTAssertNotNil(sut.genresLabel)
    }
    
    func testHasATitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func testHasABackdropImageView() {
        XCTAssertNotNil(sut.backdropImageView)
    }
    
    func testHasABookButton() {
        XCTAssertNotNil(sut.bookButton)
    }
    
    func testIfBookButtonHasActionAssigned() throws {
        let bookButton: UIButton = sut.bookButton
        let buttonActions = try XCTUnwrap(bookButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        XCTAssertTrue(buttonActions.contains("onBookMovieTouchUp:"))
    }
}
