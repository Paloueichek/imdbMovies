//
//  imdbMovies.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/16/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation

struct ImdbMovies: Decodable {
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let genreIDS: [Int?]
    let overview, releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case overview
        case releaseDate = "release_date"
    }
}
