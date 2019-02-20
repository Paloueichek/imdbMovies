//
//  NetworkManager.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/11/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation

protocol NetworkManager {
    func getData(with request: MovieRequest, page: Int, completion: @escaping(Result<PagedimdbMoviesResponse>) -> Void)
}

final class NetworkManagerImpl: NetworkManager {
    let apiKey = "c248cbe06e4a8ae71a6ffa96c640c1aa"
    private lazy var baseURL: URL = {
        return URL(string: "https://api.themoviedb.org")!
    }()

    let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    func getData(with request: MovieRequest, page: Int, completion: @escaping(Result<PagedimdbMoviesResponse>) -> Void) {
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        let parameters = ["page": "\(page)"].merging(request.parameters, uniquingKeysWith: +)
        let encodedURLRequest = urlRequest.encode(with: parameters)

       session.dataTask(with: encodedURLRequest, completionHandler: { (data, _, error ) in
            do {
                guard let data = data else { return }
                guard error == nil else { return  }
                let decoder = JSONDecoder()
                let getValues = try decoder.decode(PagedimdbMoviesResponse.self, from: data)
                DispatchQueue.main.async {
                    let result = Result.success(getValues)
                    completion(result)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }).resume()
    }
}

enum Result<T> {
    case success(T)
    case error(String)
}
