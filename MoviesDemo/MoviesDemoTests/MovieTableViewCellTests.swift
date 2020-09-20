//
//  MovieTableViewCellTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/19/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import MoviesDemo

struct Test {
    static let movie1 = Movie(id: 1, title: "movie 1", overview: "overview 1", popularity: 1.1)
}

class MovieTableViewCellTests: XCTestCase {
    var sut: MovieTableViewCell!

    override func setUpWithError() throws {
        super.setUp()
        let bundle = Bundle(for: MovieTableViewCell.self)
        guard let cell = bundle.loadNibNamed(MovieTableViewCell.cellIdentifier, owner: nil)?.first as? MovieTableViewCell else { return }
        sut = cell
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testConfigureCellSuccess() {
        sut.configureCell(movie: Test.movie1)
        XCTAssertEqual(sut.movie.id, Test.movie1.id)
    }
    
    func testCustomViewContainsAView() {
        let bundle = Bundle(for: MovieTableViewCell.self)
        guard let _ = bundle.loadNibNamed(MovieTableViewCell.cellIdentifier, owner: nil)?.first as? MovieTableViewCell else {
          return XCTFail("Cell did not contain a UIView")
        }
    }
}
