//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation

final class MovieDetailViewModel {
    
    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol = MovieService(httpClient: HttpClient())) {
        self.movieService = movieService
    }
    
    func fetchMovieDetails(movieID: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        movieService.fetchMovieDetails(movieID: movieID) { result in
            switch result {
            case .success(let movieDetail):
                completion(.success(movieDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
