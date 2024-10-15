//
//  ImageCacheManager.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation
import UIKit

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()

    private init() {}  // Singleton pattern
    
    // Retrieve the image from cache or download it if not available
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: url.absoluteString)
        
        // Check if the image is already in the cache
        if let cachedImage = cache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        // Download the image if it's not cached
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                // Cache the downloaded image
                self.cache.setObject(image, forKey: cacheKey)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                // Handle error or pass nil if download fails
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
