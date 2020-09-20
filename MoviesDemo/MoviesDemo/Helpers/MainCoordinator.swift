//
//  MainCoordinator.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/20/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(withViewController viewController: BaseViewController = MoviesViewController.instantiate()) {
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func redirectToMovieDetailVC(withMovie movie: Movie) {
        let movieDetailVC = MovieDetailViewController.instantiate()
        movieDetailVC.movie = movie
        movieDetailVC.coordinator = self
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
    
    func redirectToBookingVC() {
        let viewController = BookingViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
