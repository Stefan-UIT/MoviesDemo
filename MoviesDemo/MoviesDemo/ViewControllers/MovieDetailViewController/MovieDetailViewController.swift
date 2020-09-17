//
//  MovieDetailViewController.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit
import SDWebImage

final class MovieDetailViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    
    // MARK: - Variables
    var viewModel: MovieDetailViewModel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        reloadData()
    }
    
    private func initViewModel() {
        viewModel.delegate = self
        viewModel.fetchMovieDetail()
    }
    
    func reloadData() {
        titleLabel.text = viewModel.title
        genresLabel.text = viewModel.genres
        languagesLabel.text = viewModel.languages
        durationLabel.text = viewModel.duration
        overviewLabel.text = viewModel.overview
        
        guard
            let urlString = viewModel.backdropUrl,
            let backdropUrl = URL(string: urlString) else { return }
        backdropImageView.sd_setImage(with: backdropUrl, placeholderImage: Images.placeholder, options: .progressiveLoad)
    }
    
    @IBAction func onBookMovieTouchUp(_ sender: UIButton) {
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
