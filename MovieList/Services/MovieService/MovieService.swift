//
//  MovieService.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovies(searchQuery: String, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieDetails(movieID: String, completion: @escaping (Result<MovieDetail, Error>) -> Void)
}

class MovieService: MovieServiceProtocol {
    
    private let httpClient: HttpClient

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetchMovies(searchQuery: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = ApiEndpoints.movieList(query: searchQuery).urlString
        guard let url = URL(string: urlString) else { return }
        
        httpClient.getApiData(requestUrl: url, resultType: MovieResponse.self) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(result?.search ?? []))
        }
    }

    func fetchMovieDetails(movieID: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let urlString = ApiEndpoints.movieDetail(id: movieID).urlString
        guard let url = URL(string: urlString) else { return }
        
        httpClient.getApiData(requestUrl: url, resultType: MovieDetail.self) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let result = result {
                completion(.success(result))
            }
        }
    }
}
