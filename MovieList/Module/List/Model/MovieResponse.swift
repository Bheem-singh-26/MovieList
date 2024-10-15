//
//  MovieResponse.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}

struct MovieResponse: Decodable {
    let search: [Movie]?
    let totalResults: String?
    let response: String?
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults = "totalResults"
        case response = "Response"
        case errorMessage = "Error"
    }
}

