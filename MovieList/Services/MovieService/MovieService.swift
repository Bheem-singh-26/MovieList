//
//  MovieService.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation

protocol MovieServiceProtocol {
    
    func fetchMovies(searchQuery: String, page: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void)
    
    func fetchMovieDetails(movieID: String, completion: @escaping (Result<MovieDetail, Error>) -> Void)
}

class MovieService: MovieServiceProtocol {
    
    private let httpClient: HttpClient

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetchMovies(searchQuery: String, page: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchQuery
        let urlString = ApiEndpoints.movieList(query: encodedQuery, page: page).urlString
        guard let url = URL(string: urlString) else { return }
        
        httpClient.getApiData(requestUrl: url, resultType: MovieResponse.self) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let result = result {
                completion(.success(result))
            }
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
