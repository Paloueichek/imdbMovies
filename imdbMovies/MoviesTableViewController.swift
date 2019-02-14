//
//  ViewController.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/11/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import UIKit

class MoviesTableViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
   private var movies = [imdbMovies]()
           var networkManager: NetworkManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moviesTableView.register(UINib(nibName: MoviesTableViewCell.className, bundle: nil), forCellReuseIdentifier: "moviesCell")
        self.navigationItem.title = "IMDB Top Rated Movies"
      
        
        networkManager?.getData(completion: { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.movies = data.results
                self?.moviesTableView?.reloadData()
            case .error(let message):
                print(message)
            }
        })
        
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return  movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "moviesCell") as! MoviesTableViewCell
        let movie = self.movies[indexPath.row]
        cell.setupCell(model: movie)
        return cell
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
