//
//  MovieDetailViewController.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/18/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!

    let viewModel: MoviesDetailVM

    init(viewModel: MoviesDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: MovieDetailViewController.className, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = viewModel.movie.title
    }

}
