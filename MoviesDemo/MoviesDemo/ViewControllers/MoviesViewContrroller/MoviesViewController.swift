//
//  MoviesViewController.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

final class MoviesViewController: BaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    private var viewModel: MoviesViewModel!
    private var refreshControl: UIRefreshControl!
    private var adapter: MoviesListAdapter!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initAdapter()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func initAdapter() {
        adapter = MoviesListAdapter(delegate: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
    }
    
    private func initViewModel() {
        viewModel = MoviesViewModel()
        viewModel.delegate = self
        viewModel.fetchMovies()
    }
    
    private func setupUI() {
        self.title = Texts.discovery.capitalized
        setupTableView()
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl.appRefreshControl(target: self, selector: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshData() {
        viewModel.refreshData()
    }
    
    private func dismissSpinningView() {
        refreshControl.endRefreshing()
        tableView.stopFooterLoading()
    }
    
    private func setupTableView() {
        tableView.register(MovieTableViewCell.uiNib(), forCellReuseIdentifier: MovieTableViewCell.cellIdentifier)
    }
}

// MARK: - MoviesViewModelDelegate
extension MoviesViewController: MoviesViewModelDelegate {
    func didFinishFetchingData(in viewModel: MoviesViewModel) {
        dismissSpinningView()
    }
    
    func didLoadDataSuccessfully(in viewModel: MoviesViewModel) {
        tableView.reloadData()
    }
    
    func moviesViewModel(_ viewModel: MoviesViewModel, didFailWithError error: Error) {
        showAlert(message: Messages.couldNotGetMoviesData)
    }
    
    func loadingMoreItems(in viewModel: MoviesViewModel) {
        tableView.addFooterLoading()
    }
}

// MARK: - MoviesViewController
extension MoviesViewController: MoviesListProtocol {
    func movie(at indexPath: IndexPath) -> Movie {
        viewModel.movie(at: indexPath.row)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let movie = viewModel.movie(at: indexPath.row)
        coordinator?.redirectToMovieDetailVC(withMovie: movie)
    }
    
    func wilDisplayItem(at indexPath: IndexPath) {
        viewModel.loadMoreItemIfNeeded(atRow: indexPath.row)
    }
    
    func retrieveNumberOfItems() -> Int {
        viewModel.numberOfItems
    }
}
