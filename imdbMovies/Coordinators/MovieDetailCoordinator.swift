//
//  MovieDetailCoordinator.swift
//  imdbMovie
//
//  Created by Patrick Aloueichek on 2/18/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailCoordinator: Coordinator {
  
    let presenter: UINavigationController
    var movies: [ImdbMovies]
    
    init(presenter: UINavigationController, movies: [ImdbMovies]) {
        self.presenter = presenter
        self.movies = movies
        let detailVC = MovieDetailViewController(nibName: "MoviesTableViewController", bundle: nil)
        presenter.pushViewController(detailVC, animated: false)
    }
    
    func start() {
       
    }
}
