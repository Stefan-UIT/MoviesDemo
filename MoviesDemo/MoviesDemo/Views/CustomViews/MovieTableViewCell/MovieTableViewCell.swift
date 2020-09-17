//
//  MovieTableViewCell.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit
import SDWebImage

final class MovieTableViewCell: UITableViewCell {
    static let cellIdentifier = "MovieTableViewCell"
    
    // MARK: - IBOutlet
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Variables
    var movie: Movie!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // prevent re-use wrong image
        cancelLoadingImage()
    }
    
    // MARK: - Methods
    func configureCell(movie: Movie) {
        self.movie = movie
        setupData(withMovie: movie)
    }
    
    private func cancelLoadingImage() {
        posterImageView.sd_cancelCurrentImageLoad()
        posterImageView.image = Images.errorPoster
    }
    
    private func setupData(withMovie movie: Movie) {
        titleLabel.text = movie.title
        popularityLabel.text = movie.popularityText
        descriptionLabel.text = movie.overview
        loadPosterImage(urlString: movie.posterUrl)
    }
    
    private func loadPosterImage(urlString: String?) {
        guard let url = urlString, let imageURL = URL(string: url) else {
            posterImageView.image = Images.errorPoster
            return
        }
        posterImageView.sd_setImage(with: imageURL, placeholderImage: Images.placeholder, options: .progressiveLoad)
    }
}

protocol UINibable {
    static func uiNib() -> UINib
}

extension MovieTableViewCell: UINibable {
    static func uiNib() -> UINib {
        return UINib(nibName: MovieTableViewCell.cellIdentifier, bundle: nil)
    }
}
