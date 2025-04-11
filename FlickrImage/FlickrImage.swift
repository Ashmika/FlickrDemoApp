//
//  FlickerImage.swift
//  FlickerDemoApp
//
//  Created by Ashmika on 11/04/25.
//

import Foundation

/// Get the Response object to parse the Flickr public feed
struct FlickrResponse: Codable {
    let items: [FlickrImage]
}

/// Represents a single Flickr photo  item
struct FlickrImage: Codable {
    let title: String
    let media: Media

    /// Represents the media associated with a Flickr Image
    struct Media: Codable {
        let m: String
    }
}
