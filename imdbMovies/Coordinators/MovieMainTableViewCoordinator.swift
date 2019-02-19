//
//  MainCoordinator.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/12/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation
import UIKit

class MovieMainTableViewCoordinator: Coordinator {
    let window: UIWindow
    var rootViewController: UINavigationController
    var movieDetailCoordinator: MovieDetailCoordinator?

    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        let homeVC = MoviesTableViewController(nibName: "MoviesTableViewController", bundle: nil)
        homeVC.viewModel =  MoviesTableViewControllerVM( delegate: homeVC as MoviesTableViewControllerDelegate, coordinator: self)
        rootViewController.pushViewController(homeVC, animated: false)
    }
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    func openMovieDetail(forRequested movie: ImdbMovies) {
        let movieDetailCoordinator = MovieDetailCoordinator(presenter: rootViewController, movie: movie)
        movieDetailCoordinator.start()
    }
}
