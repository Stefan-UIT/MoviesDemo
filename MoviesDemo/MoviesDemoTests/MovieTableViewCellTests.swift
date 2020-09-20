//
//  MovieTableViewCellTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/19/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import MoviesDemo

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
        sut.configureCell(movie: TConstants.movie1)
        XCTAssertEqual(sut.movie.id, TConstants.movie1.id)
    }
    
    func testPrepareForReuseSuccess() {
        sut.prepareForReuse()
        XCTAssertNil(sut.imageView?.image)
    }
    
    func testCustomViewContainsAView() {
        let bundle = Bundle(for: MovieTableViewCell.self)
        guard let _ = bundle.loadNibNamed(MovieTableViewCell.cellIdentifier, owner: nil)?.first as? MovieTableViewCell else {
          return XCTFail("Cell did not contain a UIView")
        }
    }
}
