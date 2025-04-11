//
//  FlickerImageViewModel.swift
//  FlickerDemoApp
//
//  Created by Ashmika on 11/04/25.
//

import Foundation

class FlickrImageViewModel {
    var items: [FlickrImage] = []

    /// Loads Flickr items using WebService
    func loadImages(completion: @escaping () -> Void) {
        WebService.shared.fetchFlickrPhotos { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let images):
                    print(images)
                    self?.items = images
                    completion()
                case .failure(let error):
                    print("Failed to fetch images:", error.localizedDescription)
                }
            }
        }
    }
}
