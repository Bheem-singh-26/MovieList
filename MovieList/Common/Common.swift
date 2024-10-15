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
}

struct KeyConstants {
    static let apiKey = "bc6cd617"
}

enum ApiEndpoints {
    
    case movieList(query: String)
    case movieDetail(id: String)
    
    var urlString: String {
        switch self {
        case .movieList(query: let query):
            let urlString = "http://www.omdbapi.com/?apikey=\(KeyConstants.apiKey)&s=\(query)"
            return urlString
        case .movieDetail(id: let id):
            let urlString = "http://www.omdbapi.com/?apikey=\(KeyConstants.apiKey)&i=\(id)"
            return urlString
        }
    }
}
