//
//  MoviesDetailVM.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/18/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation
import UIKit

class MoviesDetailVM {
    weak var coordinator: MovieMainTableViewCoordinator?
    let movie: ImdbMovies

    init(movie: ImdbMovies) {
        self.movie = movie
    }
}
