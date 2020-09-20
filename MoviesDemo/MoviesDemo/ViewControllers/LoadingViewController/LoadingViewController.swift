//
//  LoadingViewController.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

final class LoadingViewController: BaseViewController {
    private var viewModel: MoviesViewModel!

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
        viewModel = MoviesViewModel()
        viewModel.delegate = self
    }
}

// MARK: - MoviesViewModelDelegate
extension LoadingViewController: MoviesViewModelDelegate {
    func didFinishFetchingData(in model: MoviesViewModel) {
    }
    
    func didLoadDataSuccessfully(in model: MoviesViewModel) {
//        coordi÷nator?.redirectToMoviesViewController(movies: vie)
    }
    
    func moviesViewModel(_ model: MoviesViewModel, didFailWithError error: Error) {
        showAlert(message: Messages.couldNotGetMoviesData)
    }
}
