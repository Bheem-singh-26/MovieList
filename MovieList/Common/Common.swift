//
//  Common.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation

struct Constants {
    static let ErrorAlertTitle = "Error"
    static let OkAlertTitle = "Ok"
    static let CancelAlertTitle = "Cancel"
    static let tooManyResults = "There are too many results avaiable for this search"
}

struct KeyConstants {
    static let apiKey = "bc6cd617"
}

enum ApiEndpoints {
    
    case movieList(query: String, page: Int)
    case movieDetail(id: String)
    
    var urlString: String {
        switch self {
        case .movieList(let query, let page):
            let urlString = "http://www.omdbapi.com/?apikey=\(KeyConstants.apiKey)&s=\(query)&page=\(page)"
            return urlString
        case .movieDetail(let id):
            let urlString = "http://www.omdbapi.com/?apikey=\(KeyConstants.apiKey)&i=\(id)"
            return urlString
        }
    }
}
