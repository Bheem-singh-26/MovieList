//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation

class MovieListViewModel {
    
    private let movieService: MovieServiceProtocol
    var movies: [Movie] = []
    var reloadMovies: (() -> Void)?
    var showError: ((String) -> Void)?
    
    private var currentPage = 1
    private var totalResults = 0
    private var isFetching = false
    private var currentQuery: String = ""
    
    init(movieService: MovieServiceProtocol = MovieService(httpClient: HttpClient())) {
        self.movieService = movieService
    }
    
    // Fetch movies for a specific search query, with pagination support
    func searchMovies(query: String, page: Int = 1) {
        resetPage(for: query)
        if isFetching { return }  // Avoid multiple requests at once
        isFetching = true
        currentQuery = query
        
        movieService.fetchMovies(searchQuery: query, page: page) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .success(let response):
                if response.errorMessage != nil {
                    self.showError?(Constants.tooManyResults)
                    return
                }
                if page == 1 {
                    // If it's the first page, reset the movie list
                    self.movies = response.search ?? []
                } else {
                    // Append new movies for subsequent pages
                    self.movies.append(contentsOf: response.search ?? [])
                }
                self.totalResults = Int(response.totalResults ?? "0") ?? 0
                self.reloadMovies?()
                
            case .failure(let error):
                self.showError?(error.localizedDescription)
            }
        }
    }
    
    // If fresh search
    func resetPage(for query: String) {
        if query != currentQuery {
            currentPage = 1
        }
    }
    
    // Check if there are more movies to fetch based on total results and page size (assuming 10 items per page)
    func canLoadMoreMovies() -> Bool {
        return movies.count < totalResults
    }
    
    // Load more movies for the current query
    func loadMoreMovies() {
        if isFetching { return }  // Avoid multiple requests at once
        if canLoadMoreMovies() {
            currentPage += 1
            searchMovies(query: currentQuery, page: currentPage)
        }
    }
}
