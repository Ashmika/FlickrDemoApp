//
//  ImageCache.swift
//  FlickerDemoApp
//
//  Created by Ashmika on 11/04/25.
//

import Foundation
import UIKit

/// A simple image cache using NSCache to store and retrieve images
class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    /// Fetch image from cache or download if not available
    static func getImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cached = shared.object(forKey: urlString as NSString) {
            completion(cached)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                shared.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    completion(image) 
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()

    }
}
