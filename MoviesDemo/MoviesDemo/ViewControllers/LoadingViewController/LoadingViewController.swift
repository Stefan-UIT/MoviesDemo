//
//  LoadingViewController.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {
    private var viewModel = MoviesViewModel()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    // MARK: - Private Methods
    private func initViewModel() {
        viewModel.delegate = self
        viewModel.fetchMovies()
    }
    
    private func redirectToMoviesViewController() {
        guard let moviesVC = ControllerHelper.load(MoviesViewController.self, fromStoryboard: Keys.main) else { return }
        moviesVC.viewModel = viewModel
        viewModel.delegate = moviesVC
        let nav = UINavigationController(rootViewController: moviesVC)
        ControllerHelper.window?.rootViewController = nav
    }
}

// MARK: - MoviesViewModelDelegate
extension LoadingViewController: MoviesViewModelDelegate {
    func willLoadData(in model: MoviesViewModel) {
        showSpinner(onView: view)
    }
    
    func didFinishFetchingData(in model: MoviesViewModel) {
        removeSpinner()
    }
    
    func didLoadDataSuccessfully(in model: MoviesViewModel) {
        redirectToMoviesViewController()
    }
    
    func moviesViewModel(_ model: MoviesViewModel, didFailWithError error: Error) {
        removeSpinner()
        showAlert(message: Messages.couldNotGetMoviesData)
    }
}

