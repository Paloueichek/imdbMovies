//
//  MovieRequest.swift
//  imdbMovie
//
//  Created by Patrick Aloueichek on 2/16/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation

struct MovieRequest {
    var path: String {
        return "3/movie/top_rated"
    }

    let parameters: Parameters
    private init(parameters: Parameters) {
        self.parameters = parameters
    }
}

extension MovieRequest {
    static func from(site: String) -> MovieRequest {
        let defaultParameters = ["api_key": "c248cbe06e4a8ae71a6ffa96c640c1aa", "language": "en-US"]
        return MovieRequest(parameters: defaultParameters)
    }
}
