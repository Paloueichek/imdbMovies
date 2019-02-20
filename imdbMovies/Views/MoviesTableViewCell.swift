//
//  MoviesViewCell.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/12/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTitleRating: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func setupCell(model: ImdbMovies?) {
        if let model = model {
        movieTitleLabel.text = model.title
        movieTitleRating.text = String(format: "%.1f", model.voteAverage ?? 0.0)
        movieImage.image = getImage(model: model)
        } else {
            movieTitleLabel.text = ""
            movieTitleRating.text = ""
            movieImage.image = nil
        }
    }

    func getImage(model: ImdbMovies) -> UIImage? {
        let url = "https://image.tmdb.org/t/p/w92//"
        self.movieImage.kf.setImage(with: URL(string: url + model.posterPath!))
        return self.movieImage.image
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
