//
//  ViewController.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/11/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import UIKit

class MoviesTableViewController:  UIViewController  {
    
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
    }

 
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

extension MoviesTableViewController: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.currentCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "moviesCell") as! MoviesTableViewCell
        cell.setupCell(model: viewModel.imdbMovie(at: indexPath.row))
        
        return cell
    }
}

extension MoviesTableViewController: MoviesTableViewControllerDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        moviesTableView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        print("error fetching data")
    }
}
