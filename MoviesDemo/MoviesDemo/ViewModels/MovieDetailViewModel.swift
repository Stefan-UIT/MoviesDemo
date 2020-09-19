//
//  MovieDetailViewModel.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

// MARK: - MovieDetailViewModelDelegate
protocol MovieDetailViewModelDelegate: class {
    func didLoadDataSuccessfully(in model: MovieDetailViewModel)
    func movieDetailViewModel(_ model: MovieDetailViewModel, didFailWithError error: Error)
}

// MARK: - MovieDetailViewModelDelegate
final class MovieDetailViewModel: BaseMovieViewModel {
    private var movie: Movie!
    weak var delegate: MovieDetailViewModelDelegate?
    
    var title: String {
        movie.title
    }
    
    var genres: String {
        return "\(Texts.genres.capitalized) : \(movie.generNamesWithDash)"
    }
    
    var languages: String {
        return "\(Texts.languages.capitalized) : \(movie.spokenLanguageNamesWithDash)"
    }
    
    var duration: String {
        "\(Texts.duration.capitalized) : \(movie.duration) \(Texts.minutes)"
    }
    
    var overview: String {
        movie.overview
    }
    
    var backdropUrl: String? {
        movie.backdropUrl
    }
    
    init(movie: Movie, provider: MovieNetworkable = MovieService()) {
        super.init(provider: provider)
        self.movie = movie
    }
    
    func fetchMovieDetail() {
        provider.fetchMovieDetail(movieId: movie.id,
                                  completion: { [weak self] (responseData, error) in
                                    guard let strongSelf = self else { return }
                                    guard let data = responseData else {
                                        strongSelf.delegate?.movieDetailViewModel(strongSelf, didFailWithError: error!)
                                        return
                                    }
                                    strongSelf.movie = data
                                    strongSelf.delegate?.didLoadDataSuccessfully(in: strongSelf)
        })
    }
}
