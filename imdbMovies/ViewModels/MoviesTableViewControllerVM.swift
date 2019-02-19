//
//  MoviesTableViewControllerVM.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/16/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation

protocol MoviesTableViewControllerDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class MoviesTableViewControllerVM {
    weak var coordinator: MovieMainTableViewCoordinator?
    private weak var delegate: MoviesTableViewControllerDelegate?
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false

    let client = NetworkManagerImpl()

    let site = "https://api.themoviedb.com"

    var imdbMovies = [ImdbMovies]()
    var filteredMovies = [ImdbMovies]()

    init(delegate: MoviesTableViewControllerDelegate, coordinator: MovieMainTableViewCoordinator) {
        self.delegate = delegate
        self.coordinator = coordinator
    }

    var totalCount: Int {
        return total
    }

    var currentCount: Int {
        return imdbMovies.count
    }
    
    func imdbMovie(at index: Int) -> ImdbMovies {
        return imdbMovies[index]
    }
    
    func fetchMovies() {
        let request = MovieRequest.from(site: site)
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        client.getData(with: request, page: currentPage) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.total = response.totalResults
                    self.imdbMovies.append(contentsOf: response.results)
                    if response.page > 1 {
                        let indexPathsToReload = self.calcuclateIndexPathsToReload(from: response.results)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
            
            case .error(let error):
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: error)
            }
        }
    }
    
    private func calcuclateIndexPathsToReload(from newMovies: [ImdbMovies]) -> [IndexPath]{
        let startIndex = imdbMovies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
