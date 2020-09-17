//
//  MainCoordinator.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/18/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pushToMovieDetail(withMovie movie: Movie) {
        let movieDetailVC = MovieDetailViewController.instantiate()
        movieDetailVC.viewModel = MovieDetailViewModel.init(movie: movie)
        movieDetailVC.viewModel.delegate = movieDetailVC
        movieDetailVC.coordinator = self
        navigationController.pushViewController(movieDetailVC, animated: true)
    }

    func pushToBookingVC() {
        let bookingVC = BookingViewController.instantiate()
        navigationController.pushViewController(bookingVC, animated: true)
    }
}
