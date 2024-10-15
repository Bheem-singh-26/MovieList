//
//  HttpClient.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation

enum HttpError: Error {
    case nonSuccessStatusCode(Error?)
    case jsonDecoding(Error)
}

final class HttpClient {
    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?, Error?)-> Void) {
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "get"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            guard let statusCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                _ = completionHandler(nil, HttpError.nonSuccessStatusCode(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: responseData!)
                _ = completionHandler(result, nil)
                
            } catch let error {
                debugPrint("error occured while decoding = \(error.localizedDescription)")
                _ = completionHandler(nil, HttpError.jsonDecoding(error))
            }
            
        }.resume()
    }
    
}
