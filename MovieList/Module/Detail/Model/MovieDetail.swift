//
//  MovieDetail.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation

struct MovieDetail: Decodable {
    let title: String
    let releaseDate: String
    let director: String
    let plot: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case releaseDate = "Released"
        case director = "Director"
        case plot = "Plot"
        case poster = "Poster"
    }
}
