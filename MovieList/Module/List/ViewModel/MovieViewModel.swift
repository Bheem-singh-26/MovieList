//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation

class MovieViewModel {
    private let movieService: MovieServiceProtocol
    var movies: [Movie] = []
    var reloadMovies: (() -> Void)?

    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    
    func searchMovies(query: String) {
        movieService.fetchMovies(searchQuery: query) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.reloadMovies?()
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
}
