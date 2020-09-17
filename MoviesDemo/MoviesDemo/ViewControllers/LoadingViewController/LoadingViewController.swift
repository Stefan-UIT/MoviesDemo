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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private Methods
    private func initViewModel() {
        viewModel.delegate = self
        viewModel.fetchMovies()
    }
    
    private func redirectToMoviesViewController() {
        let moviesVC = MoviesViewController.instantiate()
        moviesVC.viewModel = viewModel
        viewModel.delegate = moviesVC
        let nav = UINavigationController(rootViewController: moviesVC)
        nav.applyTheme()
        ControllerHelper.setToRootViewController(nav)
    }
}

// MARK: - MoviesViewModelDelegate
extension LoadingViewController: MoviesViewModelDelegate {
    func willLoadData(in model: MoviesViewModel) {
    }
    
    func didFinishFetchingData(in model: MoviesViewModel) {
    }
    
    func didLoadDataSuccessfully(in model: MoviesViewModel) {
        redirectToMoviesViewController()
    }
    
    func moviesViewModel(_ model: MoviesViewModel, didFailWithError error: Error) {
        showAlert(message: Messages.couldNotGetMoviesData)
    }
}

