//
//  MoviesListAdapter.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

protocol MoviesListProtocol {
    func movie(at indexPath: IndexPath) -> Movie
    func didSelectItem(at indexPath: IndexPath)
    func wilDisplayItem(at indexPath: IndexPath)
    func retrieveNumberOfItems() -> Int
}

// swiftlint:disable weak_delegate
class MoviesListAdapter: NSObject {
    let delegate: MoviesListProtocol
    // MARK: - Constructor
    init(delegate: MoviesListProtocol) {
        self.delegate = delegate
    }
}

// MARK: - UITableViewDataSource
extension MoviesListAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.retrieveNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate.wilDisplayItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return movieCell(tableView, atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 3
    }
    
    private func movieCell(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> MovieTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellIdentifier, for: indexPath) as? MovieTableViewCell else {
            return MovieTableViewCell()
        }
        let movie = delegate.movie(at: indexPath)
        cell.configureCell(movie: movie)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MoviesListAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.didSelectItem(at: indexPath)
    }
}
