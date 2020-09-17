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
    func willLoadData(in model: MoviesViewModel)
    func didFinishFetchingData(in model: MoviesViewModel)
    func didLoadDataSuccessfully(in model: MoviesViewModel)
    func moviesViewModel(_ model: MoviesViewModel, didFailWithError error: Error)
    func loadingMoreItems(in model: MoviesViewModel)
}

// MARK: - Optional MoviesViewModelDelegate
extension MoviesViewModelDelegate {
    func willLoadData(in model: MoviesViewModel) {}
    func loadingMoreItems(in model: MoviesViewModel) {}
}

// MARK: - MoviesViewModel
final class MoviesViewModel: BaseViewModel {
    private var movies = [Movie]()
    private var pagingCalculator = PagingCalculator()
    private var currentPage = 1
    private var isLastPageReached: Bool = false
    private var isFetchInProgress = false
    
    weak var delegate: MoviesViewModelDelegate?
    
    var numberOfItems: Int {
        return movies.count
    }
    
    func movie(at position: Int) -> Movie {
        return movies[position]
    }
    
    func shouldLoadMoreItems(atRow row: Int) -> Bool {
        pagingCalculator.shouldLoadMoreItems(atRow: row, numberOfItimes: numberOfItems, isLastPageReached: isLastPageReached)
    }
    
    func loadMoreItemIfNeeded(atRow row: Int) {
        if shouldLoadMoreItems(atRow: row) {
            delegate?.loadingMoreItems(in: self)
            fetchMovies()
        }
    }
    
    func refreshData() {
        resetPagingData()
        fetchMovies(isReset: true)
    }
    
    func resetPagingData() {
        currentPage = 1
        isLastPageReached = false
        isFetchInProgress = false
    }
    
    func fetchMovies(isReset: Bool = false) {
        guard !isFetchInProgress else { return }
        
        delegate?.willLoadData(in: self)
        isFetchInProgress = true
        provider.fetchMovies(page: currentPage,
                             sortBy: .primaryReleaseDateAsc,
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
                                
                                strongSelf.calculateCurrentPageAndIsLastPageReached(numberOfNewData: responseData.count)
                                strongSelf.delegate?.didLoadDataSuccessfully(in: strongSelf)
        })
    }
    
    // check if is the last page reach, so no need to load more
    private func calculateCurrentPageAndIsLastPageReached(numberOfNewData: Int) {
        isLastPageReached = numberOfNewData < Paths.dataPerPage
        if !isLastPageReached {
            currentPage += 1
        }
    }
}

// MARK: - Helpers
struct PagingCalculator {
    func shouldLoadMoreItems(atRow row: Int,
                             numberOfItimes: Int,
                             isLastPageReached: Bool) -> Bool {
        let isLastRow =  (row == numberOfItimes - 1)
        return isLastRow && !isLastPageReached
    }
}
