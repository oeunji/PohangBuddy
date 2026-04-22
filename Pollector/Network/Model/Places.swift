//
//  Places.swift
//  Pollector
//
//  Created by 이은지 on 4/22/26.
//

import Foundation
import SwiftData

@Model
final class Places {
    @Attribute(.unique) var cacheKey: String
    var keyword: String
    var placeID: String?
    var name: String
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var googleMapsURL: String?
    var rating: Double?
    var createdDate: Date

    @Relationship(deleteRule: .cascade)
    var photos: [PlacesPhoto]

    init(
        cacheKey: String,
        keyword: String,
        placeID: String? = nil,
        name: String,
        address: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        googleMapsURL: String? = nil,
        rating: Double? = nil,
        photos: [PlacesPhoto] = [],
        createdDate: Date = Date()
    ) {
        self.cacheKey = cacheKey
        self.keyword = keyword
        self.placeID = placeID
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.googleMapsURL = googleMapsURL
        self.rating = rating
        self.photos = photos
        self.createdDate = createdDate
    }

    var primaryPhoto: PlacesPhoto? {
        photos.first { photo in
            guard let imageData = photo.imageData else { return false }
            return !imageData.isEmpty
        } ?? photos.first
    }
}

@Model
final class PlacesPhoto {
    var reference: String
    var width: Int
    var height: Int
    var imageData: Data?

    init(reference: String, width: Int, height: Int, imageData: Data? = nil) {
        self.reference = reference
        self.width = width
        self.height = height
        self.imageData = imageData
    }
}
