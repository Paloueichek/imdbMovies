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
        setupDetails(model: viewModel)
    }

    private func setupDetails(model: MoviesDetailVM?) {
        if let model = model {
        movieTitleLabel.text = viewModel.movie.title
        releaseDateLabel.text = viewModel.movie.releaseDate
        movieDescriptionLabel.text = viewModel.movie.overview
        movieDescriptionLabel.numberOfLines = 12
        DispatchQueue.main.async {
            self.movieImageView.image = self.getImage(model: model)
            }
        } else {
            movieTitleLabel.text = ""
            movieTitleLabel.text = ""
            movieDescriptionLabel.text = ""
            movieImageView.image = nil

        }
    }

    func getImage(model: MoviesDetailVM) -> UIImage? {
        let url = "https://image.tmdb.org/t/p/w500//"
        self.movieImageView.kf.setImage(with: URL(string: url + model.movie.posterPath!))
        return self.movieImageView.image
    }
}
