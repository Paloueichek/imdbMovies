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
    private let presenter: UINavigationController
    private var movieDetailViewController: MovieDetailViewController?
    private var movie: ImdbMovies

    init(presenter: UINavigationController, movie: ImdbMovies) {
        self.presenter = presenter
        self.movie = movie
    }
    func start() {
        let movieDetailsVM = MoviesDetailVM(movie: movie)
        let movieDetailViewController = MovieDetailViewController(viewModel: movieDetailsVM)
        presenter.pushViewController(movieDetailViewController, animated: false)
        self.movieDetailViewController = movieDetailViewController
    }
}
