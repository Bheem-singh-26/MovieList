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
    private let apiKey = "bc6cd617"
    
    func fetchMovies(searchQuery: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "http://www.omdbapi.com/?apikey=\(apiKey)&s=\(searchQuery)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.search ?? []))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchMovieDetails(movieID: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let urlString = "http://www.omdbapi.com/?apikey=\(apiKey)&i=\(movieID)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                completion(.success(movieDetail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
