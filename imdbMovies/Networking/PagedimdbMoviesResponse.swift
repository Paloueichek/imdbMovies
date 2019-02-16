//
//  PagedimdbMoviesResponse.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/16/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation

struct PagedimdbMoviesResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [imdbMovies]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

