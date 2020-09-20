//
//  MoviesViewModel.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import Foundation

// MARK: - MoviesViewModelDelegate
protocol MoviesViewModelDelegate: class {
    func didFinishFetchingData(in viewModel: MoviesViewModel)
    func didLoadDataSuccessfully(in viewModel: MoviesViewModel)
    func moviesViewModel(_ viewModel: MoviesViewModel, didFailWithError error: Error)
    func loadingMoreItems(in viewModel: MoviesViewModel)
}

// MARK: - Optional MoviesViewModelDelegate
extension MoviesViewModelDelegate {
    func loadingMoreItems(in viewModel: MoviesViewModel) {}
}

// MARK: - MoviesViewModel
final class MoviesViewModel {
    private var provider: MovieNetworkable
    private var pagingCalculator: PagingCalculable
    private var movies: [Movie]
    private var currentPage: Int
    private var isLastPageReached: Bool = false
    private var isFetchInProgress = false
    
    weak var delegate: MoviesViewModelDelegate?
    
    init(movies: [Movie] = [Movie](),
         currentPage: Int = 1,
         pagingCalculator: PagingCalculable = PagingCalculator(),
         provider: MovieNetworkable = MovieService()) {
        self.provider = provider
        self.movies = movies
        self.currentPage = currentPage
        self.pagingCalculator = pagingCalculator
    }
    
    var numberOfItems: Int {
        return movies.count
    }
    
    func movie(at position: Int) -> Movie {
        return movies[position]
    }
    
    func loadMoreItemIfNeeded(atRow row: Int) {
        let shouldLoadMoreItems = pagingCalculator.shouldLoadMoreItems(atRow: row, numberOfItimes: numberOfItems, isLastPageReached: isLastPageReached)
        
        if shouldLoadMoreItems {
            delegate?.loadingMoreItems(in: self)
            fetchMovies()
        }
    }
    
    func refreshData() {
        resetPagingData()
        fetchMovies(isReset: true)
    }
    
    private func resetPagingData() {
        currentPage = 1
        isLastPageReached = false
        isFetchInProgress = false
    }
    
    private func calculatingPaginationData(numberOfNewItems: Int) {
        isLastPageReached = pagingCalculator.isLastPageReached(numberOfNewItems: numberOfNewItems, dataPerPage: Paths.movieDataPerPage)
        currentPage = pagingCalculator.calculatingCurrentPage(currentPage, isLastPage: isLastPageReached)
        
    }
    
    func fetchMovies(isReset: Bool = false) {
        guard !isFetchInProgress else { return }
        
        isFetchInProgress = true
        provider.fetchMovies(page: currentPage,
                             sortBy: .releaseDateAsc,
                             completion: { [weak self] (responseData, error) in
                                guard let strongSelf = self else { return }
                                strongSelf.isFetchInProgress = false
                                strongSelf.delegate?.didFinishFetchingData(in: strongSelf)
                                
                                guard let responseData = responseData else {
                                    strongSelf.delegate?.moviesViewModel(strongSelf, didFailWithError: error!)
                                    return
                                }
                                if isReset {
                                    strongSelf.movies.removeAll()
                                }
                                strongSelf.movies.append(contentsOf: responseData)
                                strongSelf.calculatingPaginationData(numberOfNewItems: responseData.count)
                                strongSelf.delegate?.didLoadDataSuccessfully(in: strongSelf)
        })
    }
}
