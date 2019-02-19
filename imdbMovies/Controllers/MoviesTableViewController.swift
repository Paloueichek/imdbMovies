//
//  ViewController.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/11/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import UIKit

class MoviesTableViewController: UIViewController, AlertDisplayer {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var viewModel: MoviesTableViewControllerVM!
    private var shouldShowLoadingCell = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupMovieTableView()
        setupSearch()
    }

    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    private func setupMovieTableView() {
        moviesTableView.register(UINib(nibName: MoviesTableViewCell.className,
                                       bundle: nil), forCellReuseIdentifier: "moviesCell")
        navigationItem.title = "IMDB Top Rated"

        viewModel.fetchMovies()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.prefetchDataSource = self
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
            viewModel.filteredMovies = viewModel.imdbMovies.filter({(movie: ImdbMovies) -> Bool in
                guard let movieSearch = movie.title?.lowercased().contains(searchText.lowercased()) else { return false }
                return movieSearch
            })
        self.moviesTableView.reloadData()
    }
}

extension MoviesTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return viewModel.filteredMovies.count
        }
        return viewModel.totalCount
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.filteredMovies[indexPath.row]
        viewModel.coordinator?.openMovieDetail(forRequested: selectedMovie)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: "moviesCell")
            as? MoviesTableViewCell else { return UITableViewCell() }
        let movie: ImdbMovies
        if isFiltering() {
            movie = viewModel.filteredMovies[indexPath.row]
            cell.setupCell(model: movie)
        } else {
            if isLoadingCell(for: indexPath) {
                cell.setupCell(model: .none)
            } else {
                cell.setupCell(model: self.viewModel.imdbMovie(at: indexPath.row))
            }
        }
        return cell
    }
}

extension MoviesTableViewController: MoviesTableViewControllerDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            moviesTableView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        moviesTableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
        let title = "Warning"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title, message: reason, actions: [action])
    }
}

extension MoviesTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchMovies()
        }
    }
}

private extension MoviesTableViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = moviesTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

extension MoviesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
