//
//  MoviesViewController.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var viewModel: MoviesViewModel!
    private var refreshControl = UIRefreshControl()
    private var adapter: MoviesListAdapter!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initAdapter()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - Private Methods
    private func redirectToMovieDetail(withMovie movie: Movie) {
        guard let movieDetailVC = ControllerHelper.load(MovieDetailViewController.self, fromStoryboard: Keys.main) else { return }
        let vModel = MovieDetailViewModel.init(movie: movie)
        movieDetailVC.viewModel = vModel
        vModel.delegate = movieDetailVC
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    private func initAdapter() {
        adapter = MoviesListAdapter(delegate: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
    }
    
    private func initViewModel() {
        viewModel.delegate = self
        viewModel.fetchMovies()
    }
    
    private func setupUI() {
        self.title = Texts.discovery.capitalized
        setupTableView()
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = UIColor.lightGray
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributedTitle = NSAttributedString(string: Messages.pullToRefresh, attributes: attributes)
        refreshControl.attributedTitle = attributedTitle
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refreshData() {
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
    func willLoadData(in model: MoviesViewModel) {
    }
    
    func didFinishFetchingData(in model: MoviesViewModel) {
        dismissSpinningView()
    }
    
    func didLoadDataSuccessfully(in model: MoviesViewModel) {
        tableView.reloadData()
    }
    
    func moviesViewModel(_ model: MoviesViewModel, didFailWithError error: Error) {
        showAlert(message: Messages.couldNotGetMoviesData)
    }
    
    func loadingMoreItems(in model: MoviesViewModel) {
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
        redirectToMovieDetail(withMovie: movie)
    }
    
    func wilDisplayItem(at indexPath: IndexPath) {
        viewModel.loadMoreItemIfNeeded(atRow: indexPath.row)
    }
    
    func retrieveNumberOfItems() -> Int {
        viewModel.numberOfItems
    }
}
