//
//  SearchViewModel.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/21/26.
//

import Foundation
import Combine
import CoreLocation
import GooglePlacesSwift
import SwiftData

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var stampStatuses: [StampStatusModel] = []
    @Published var errorMessage: String?

    private let service: PlacesServicing

    init(service: PlacesServicing) {
        self.service = service
    }

    convenience init() {
        self.init(service: PlacesService())
    }

    func search(keyword: String) async {
        do {
            places = try await service.searchByText(keyword: keyword)
            errorMessage = nil
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = NetworkError.unknownError.localizedDescription
        }
    }

    func loadStampStatuses(for baseStatuses: [StampStatusModel], modelContext: ModelContext) async {
        stampStatuses = baseStatuses

        var updatedStatuses: [StampStatusModel] = []
        var latestErrorMessage: String?

        for status in baseStatuses {
            let keyword = status.title
            let cacheKey = makeCacheKey(keyword: keyword)

            if let cachedPlace = fetchCachedPlace(cacheKey: cacheKey, modelContext: modelContext) {
                logCacheHit(keyword: keyword)
                updatedStatuses.append(makeStampStatus(from: cachedPlace, fallback: status))
                continue
            }

            logCacheMiss(keyword: keyword)

            do {
                let places = try await service.searchByText(keyword: keyword)

                guard let place = places.first else {
                    updatedStatuses.append(status)
                    continue
                }

                let cachedPlace = makeCachedPlace(
                    from: place,
                    keyword: keyword,
                    cacheKey: cacheKey,
                    fallback: status
                )

                modelContext.insert(cachedPlace)
                try? modelContext.save()

                updatedStatuses.append(makeStampStatus(from: cachedPlace, fallback: status))
            } catch let error as NetworkError {
                latestErrorMessage = error.localizedDescription
                updatedStatuses.append(status)
            } catch {
                latestErrorMessage = NetworkError.unknownError.localizedDescription
                updatedStatuses.append(status)
            }
        }

        stampStatuses = updatedStatuses
        errorMessage = latestErrorMessage
    }

    private func makeCacheKey(keyword: String) -> String {
        "pohang:\(keyword)"
    }

    private func fetchCachedPlace(cacheKey: String, modelContext: ModelContext) -> Places? {
        let descriptor = FetchDescriptor<Places>(
            predicate: #Predicate { place in
                place.cacheKey == cacheKey
            },
            sortBy: [
                SortDescriptor(\.createdDate, order: .reverse)
            ]
        )

        return try? modelContext.fetch(descriptor).first
    }

    private func makeCachedPlace(
        from place: Place,
        keyword: String,
        cacheKey: String,
        fallback: StampStatusModel
    ) -> Places {
        let photos = place.photos?.map { photo in
            PlacesPhoto(
                reference: photo.description,
                width: Int(photo.maxSize.width),
                height: Int(photo.maxSize.height)
            )
        } ?? []

        return Places(
            cacheKey: cacheKey,
            keyword: keyword,
            placeID: place.placeID,
            name: place.displayName ?? fallback.detail.placeName,
            address: place.formattedAddress,
            latitude: place.location.latitude,
            longitude: place.location.longitude,
            googleMapsURL: nil,
            rating: place.rating.map(Double.init),
            photos: photos
        )
    }

    private func makeStampStatus(from cachedPlace: Places, fallback: StampStatusModel) -> StampStatusModel {
        StampStatusModel(
            id: cachedPlace.name,
            title: fallback.title,
            state: fallback.state,
            detail: StampDetailModel(
                navigationTitle: "미션! \(fallback.title)",
                imageName: fallback.detail.imageName,
                placeName: cachedPlace.name,
                address: cachedPlace.address ?? fallback.detail.address,
                distanceText: fallback.detail.distanceText,
                priceText: fallback.detail.priceText,
                reviewTitle: fallback.detail.reviewTitle,
                reviewPrompt: fallback.detail.reviewPrompt,
                reviewPlaceholder: fallback.detail.reviewPlaceholder,
                actionButtonTitle: fallback.detail.actionButtonTitle,
                actionButtonImageName: fallback.detail.actionButtonImageName
            )
        )
    }

    private func logCacheHit(keyword: String) {
        #if DEBUG
        print("💾 [PlacesCache] hit: \(keyword)")
        #endif
    }

    private func logCacheMiss(keyword: String) {
        #if DEBUG
        print("🌐 [PlacesCache] miss: \(keyword)")
        #endif
    }
}
