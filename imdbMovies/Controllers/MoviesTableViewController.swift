//
//  ViewController.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/11/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import UIKit

class MoviesTableViewController:  UIViewController, AlertDisplayer  {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var site: String = "https://api.themoviedb.org3/movie/top_rated?"
    
    private var viewModel: MoviesTableViewControllerVM!
    private var shouldShowLoadingCell = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moviesTableView.register(UINib(nibName: MoviesTableViewCell.className, bundle: nil), forCellReuseIdentifier: "moviesCell")
        self.navigationItem.title = "IMDB Top Rated Movies"
        
        let request = MovieRequest.from(site: site)

        viewModel = MoviesTableViewControllerVM(request: request, delegate: self as! MoviesTableViewControllerDelegate)
        
        viewModel.fetchMovies()
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        self.moviesTableView.prefetchDataSource = self
    }
}

extension MoviesTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "moviesCell") as! MoviesTableViewCell
        if isLoadingCell(for: indexPath){
            cell.setupCell(model: .none)
        } else {
                cell.setupCell(model: viewModel.imdbMovie(at: indexPath.row))
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
        displayAlert(with: title , message: reason, actions: [action])
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
