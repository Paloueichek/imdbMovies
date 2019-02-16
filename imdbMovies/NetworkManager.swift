//
//  NetworkManager.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/11/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation


protocol NetworkManager {
    func getData(completion: @escaping(Result<Movies>)->())
}

final class NetworkManagerImpl: NetworkManager {
    
    let apiKey = "c248cbe06e4a8ae71a6ffa96c640c1aa"
    let baseURL = "https://api.themoviedb.org/3/movie/top_rated?api_key="
    
    
    func getData(completion: @escaping(Result<Movies>) ->()) {
    
        let url = URL(string: baseURL + apiKey)
        let request = URLRequest(url: url!)
    
        let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
            do {
                guard let data = data else { return }
                guard error == nil else { return  }
                let decoder = JSONDecoder()
                let getValues = try decoder.decode(Movies.self, from: data)
                print(getValues.results)
                DispatchQueue.main.async {
                    let result = Result.success(getValues)
                    completion(result)
                }
              
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
 
}

enum Result<T> {
    case success(T)
    case error(String)
}

struct Movies: Codable {
    let results: [imdbMovies]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}


