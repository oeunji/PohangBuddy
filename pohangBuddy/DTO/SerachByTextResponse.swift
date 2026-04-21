//
//  SerachByTextResponse.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/21/26.
//

import Foundation
import CoreLocation
import GooglePlacesSwift

struct PlaceItem {
    let id: String
    let name: String
    let address: String
    let location: CLLocationCoordinate2D?
    let photos: [Photo]
}

//extension PlaceItem {
//    init?(place: Place) {
//        guard let id = place.id, let name = place.displayName?.text else {
//            return nil
//        }
//
//        self.id = id
//        self.name = name
//        self.address = place.formattedAddress ?? ""
//        self.location = place.location
//        self.photos = place.photos ?? []
//    }
//}

// MARK: - Response
// let response = await PlacesClient.shared.searchByText(with: request)
