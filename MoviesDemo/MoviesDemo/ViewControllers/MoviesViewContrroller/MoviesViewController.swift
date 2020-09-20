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
    var movies = [Movie]()
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
        viewModel = MoviesViewModel(movies: movies)
        viewModel.delegate = self
        if movies.isEmpty {
            viewModel.fetchMovies()
        }
    }
    
    private func setupUI() {
        self.title = Texts.discovery.capitalized
        setupTableView()
        setupRefreshControl()
    }
    
    // move to static func and func addToTableView(tableView:UITableView)
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
        coordinator?.redirectToMovieDetailVC(withMovie: movie)
    }
    
    func wilDisplayItem(at indexPath: IndexPath) {
        viewModel.loadMoreItemIfNeeded(atRow: indexPath.row)
    }
    
    func retrieveNumberOfItems() -> Int {
        viewModel.numberOfItems
    }
}

extension UIRefreshControl {
    static func appRefreshControl(target: UIViewController,
                                  title: String = Messages.pullToRefresh,
                                  selector: Selector,
                                  for event: UIControl.Event = .valueChanged) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.lightGray
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        refreshControl.attributedTitle = attributedTitle
        refreshControl.addTarget(target, action: selector, for: event)
        
        return refreshControl
    }
}
