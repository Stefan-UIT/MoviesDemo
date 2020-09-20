//
//  MovieDetailViewController.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit
import SDWebImage
import WebKit

final class MovieDetailViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var bookButton: UIButton!
    
    // MARK: - Variables
    private var viewModel: MovieDetailViewModel!
    var movie: Movie!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        reloadData()
    }
    
    // MARK: - Private Methods
    private func initViewModel() {
        viewModel = MovieDetailViewModel(movie: movie)
        viewModel.delegate = self
        viewModel.fetchMovieDetail()
    }
    
    private func reloadData() {
        setupUI()
        loadBackdropImage()
    }
    
    private func setupUI() {
        titleLabel.text = viewModel.title
        genresLabel.text = viewModel.genres
        languagesLabel.text = viewModel.languages
        durationLabel.text = viewModel.duration
        overviewLabel.text = viewModel.overview
    }
    
    private func loadBackdropImage() {
        guard
            let backdropUrl = viewModel.backdropUrl else {
                backdropImageView.image = Images.errorPoster
                return
        }
        backdropImageView.sd_setImage(with: backdropUrl, placeholderImage: nil, options: .progressiveLoad)
    }
    
    // MARK: - Actions
    @IBAction func onBookMovieTouchUp(_ sender: UIButton) {
        coordinator?.redirectToBookingVC()
    }
}

// MARK: - MovieDetailViewModelDelegate
extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func didLoadDataSuccessfully(in model: MovieDetailViewModel) {
        reloadData()
    }
    
    func movieDetailViewModel(_ model: MovieDetailViewModel, didFailWithError error: Error) {
        showAlert(message: Messages.couldNotGetMovieDetail)
    }
}
