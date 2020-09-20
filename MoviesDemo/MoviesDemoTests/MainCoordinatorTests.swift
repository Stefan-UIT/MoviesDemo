//
//  MainCoordinatorTests.swift
//  MoviesDemoTests
//
//  Created by Trung Vo on 9/20/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import XCTest
@testable import MoviesDemo

class MainCoordinatorTests: XCTestCase {
    var sut: MainCoordinator!
    var navController: UINavigationController!
    var moviesVC: MoviesViewController!

    override func setUpWithError() throws {
        super.setUp()
        navController = UINavigationController()
        moviesVC = MoviesViewController()
        sut = MainCoordinator(navigationController: navController)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testStartIsWorked() throws {
        XCTAssertEqual(sut.navigationController.viewControllers.count, 0)
        sut.start(withViewController: moviesVC)
        let result = try XCTUnwrap(sut.navigationController.viewControllers.first)
        XCTAssertEqual(result, moviesVC)
    }
    
    func testRedirectToMovieDetailVCSuccess() throws {
        sut.redirectToMovieDetailVC(withMovie: TConstants.movie1)
        let result = try XCTUnwrap(sut.navigationController.viewControllers[0] as? MovieDetailViewController)
        XCTAssertEqual(result.movie.id, TConstants.movie1.id)
    }
    
    func testRedirectToBookingVCSuccess() throws {
        sut.redirectToBookingVC()
        let result = try XCTUnwrap(sut.navigationController.viewControllers[0] is BookingViewController)
        XCTAssertTrue(result)
    }
}
