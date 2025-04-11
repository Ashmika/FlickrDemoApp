//
//  WebService.swift
//  FlickerDemoApp
//
//  Created by Ashmika on 11/04/25.
//

import Foundation

//Singleton class responsible for fetching data from Flickr
class WebService {
    static let shared = WebService()
    
    private init() {}
    
    private let endpoint = "https://www.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
    
    /// Fetches public images from Flickr API
    func fetchFlickrPhotos(completion: @escaping (Result<[FlickrImage], Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            return completion(.failure(URLError(.badURL)))
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(URLError(.badServerResponse)))
            }

            do {
                let result = try JSONDecoder().decode(FlickrResponse.self, from: data)
                completion(.success(result.items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
