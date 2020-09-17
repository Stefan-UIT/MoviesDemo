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
    func willLoadData(in model: MovieDetailViewModel)
    func didFinishFetchingData(in model: MovieDetailViewModel)
    func didLoadDataSuccessfully(in model: MovieDetailViewModel)
    func movieDetailViewModel(_ model: MovieDetailViewModel, didFailWithError error: Error)
}

// MARK: - Optional MovieDetailViewModelDelegate
extension MovieDetailViewModelDelegate {
    func willLoadData(in model: MoviesViewModel) {}
}

// MARK: - MovieDetailViewModelDelegate
final class MovieDetailViewModel: BaseViewModel {
    private var movie: Movie!
    weak var delegate: MovieDetailViewModelDelegate?
    
    var title: String {
        movie.title
    }
    
    var genres: String {
        movie.generNames
    }
    
    var languages: String {
        movie.spokenLanguageNames
    }
    
    var duration: String {
        movie.duration
    }
    
    var overview: String {
        movie.overview
    }
    
    var backdropUrl: String? {
        movie.backdropUrl
    }
    
    init(movie: Movie, provider: Networkable = NetworkManager()) {
        super.init(provider: provider)
        self.movie = movie
    }
    
    func fetchMovieDetail() {
        delegate?.willLoadData(in: self)
        provider.fetchMovieDetail(movieId: movie.id,
                              completion: { [weak self] (responseData, error) in
                                guard let strongSelf = self else { return }
                                strongSelf.delegate?.didFinishFetchingData(in: strongSelf)
                                
                                guard let data = responseData else {
                                    strongSelf.delegate?.movieDetailViewModel(strongSelf, didFailWithError: error!)
                                    return
                                }
                                strongSelf.movie = data
                                strongSelf.delegate?.didLoadDataSuccessfully(in: strongSelf)
        })
    }
}
