//
//  PlacesService.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/21/26.
//

import Foundation
import CoreLocation
import GooglePlacesSwift

protocol PlacesServicing {
    func searchByText(keyword: String) async throws -> [Place]
}

@MainActor
final class PlacesService: PlacesServicing {
    private let clientProvider: @MainActor () -> PlacesClient

    init(clientProvider: @escaping @MainActor () -> PlacesClient = { PlacesClient.shared }) {
        self.clientProvider = clientProvider
    }

    convenience init(client: PlacesClient) {
        self.init(clientProvider: { client })
    }

    func searchByText(keyword: String) async throws -> [Place] {
        let properties: [PlaceProperty] = [
            .displayName,
            .formattedAddress,
            .coordinate,
            .photos
        ]

        let pohangBias = CircularCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 36.0190, longitude: 129.3435),
            radius: 20_000
        )

        let request = SearchByTextRequest(
            textQuery: "포항 \(keyword)",
            placeProperties: properties,
            locationBias: pohangBias,
            includedType: nil,
            maxResultCount: 10,
            minRating: 0.0,
            isOpenNow: false,
            priceLevels: nil,
            rankPreference: .relevance,
            regionCode: "KR",
            isStrictTypeFiltering: false,
            shouldIncludePureServiceAreaBusinesses: false
        )

        let result = await clientProvider().searchByText(with: request)

        switch result {
        case .success(let places):
            return places
        case .failure(let error):
            throw NetworkError.placesError(error)
        }
    }
}
