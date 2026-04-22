//
//  PlacesDTO.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/22/26.
//

import Foundation
import CoreLocation

struct PlacesDTO {
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let googleMapsURL: String
    let photos: [PlacesPhotoDTO]
}

extension PlacesDTO {
    func toModel() -> Places {
        Places(
            cacheKey: name,
            keyword: name,
            name: name,
            address: address,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            googleMapsURL: googleMapsURL,
            photos: photos.map { $0.toModel() }
        )
    }
}

struct PlacesPhotoDTO {
    let reference: String
    let width: Int
    let height: Int
    let imageData: Data?
}

extension PlacesPhotoDTO {
    func toModel() -> PlacesPhoto {
        PlacesPhoto(
            reference: reference,
            width: width,
            height: height,
            imageData: imageData
        )
    }
}
