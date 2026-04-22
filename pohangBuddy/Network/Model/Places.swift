//
//  Places.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/22/26.
//

import Foundation
import CoreLocation

struct Places {
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let googleMapsURL: String
    let photos: [PlacesPhoto]
}

struct PlacesPhoto {
    let reference: String
    let width: Int
    let height: Int
}
