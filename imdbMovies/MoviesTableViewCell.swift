//
//  MoviesViewCell.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/12/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieTitleRating: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
