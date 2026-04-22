//
//  SearchViewModel.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/21/26.
//

import Foundation
import Combine
import CoreGraphics
import CoreLocation
import GooglePlacesSwift
import SwiftData
import UIKit

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchResults: [Place] = []
    @Published var places: [Places] = []
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
            searchResults = try await service.searchByText(keyword: keyword)
            errorMessage = nil
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = NetworkError.unknownError.localizedDescription
        }
    }

    func loadPlaces(for keywords: [String], modelContext: ModelContext) async {
        places = keywords.map { keyword in
            makePlaceholderPlace(keyword: keyword)
        }

        var updatedPlaces: [Places] = []
        var latestErrorMessage: String?

        for keyword in keywords {
            let cacheKey = makeCacheKey(keyword: keyword)

            if let cachedPlace = fetchCachedPlace(cacheKey: cacheKey, modelContext: modelContext) {
                logCacheHit(keyword: keyword)
                if hasRenderablePhoto(cachedPlace) {
                    updatedPlaces.append(cachedPlace)
                    continue
                }

                do {
                    try await refreshCachedPlace(cachedPlace, keyword: keyword, modelContext: modelContext)
                    updatedPlaces.append(cachedPlace)
                    continue
                } catch let error as NetworkError {
                    latestErrorMessage = error.localizedDescription
                    updatedPlaces.append(cachedPlace)
                    continue
                } catch {
                    latestErrorMessage = NetworkError.unknownError.localizedDescription
                    updatedPlaces.append(cachedPlace)
                    continue
                }
            }

            logCacheMiss(keyword: keyword)

            do {
                let places = try await service.searchByText(keyword: keyword)

                guard let place = places.first else {
                    updatedPlaces.append(makePlaceholderPlace(keyword: keyword))
                    continue
                }

                let photoImageData = await fetchFirstPhotoData(from: place)
                let cachedPlace = makeCachedPlace(
                    from: place,
                    keyword: keyword,
                    cacheKey: cacheKey,
                    photoImageData: photoImageData
                )

                modelContext.insert(cachedPlace)
                try? modelContext.save()

                updatedPlaces.append(cachedPlace)
            } catch let error as NetworkError {
                latestErrorMessage = error.localizedDescription
                updatedPlaces.append(makePlaceholderPlace(keyword: keyword))
            } catch {
                latestErrorMessage = NetworkError.unknownError.localizedDescription
                updatedPlaces.append(makePlaceholderPlace(keyword: keyword))
            }
        }

        places = updatedPlaces
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
        photoImageData: Data?
    ) -> Places {
        return Places(
            cacheKey: cacheKey,
            keyword: keyword,
            placeID: place.placeID,
            name: place.displayName ?? keyword,
            address: place.formattedAddress,
            latitude: place.location.latitude,
            longitude: place.location.longitude,
            googleMapsURL: nil,
            rating: place.rating.map(Double.init),
            photos: makePlacesPhotos(from: place, photoImageData: photoImageData)
        )
    }

    private func makePlaceholderPlace(keyword: String) -> Places {
        Places(
            cacheKey: makeCacheKey(keyword: keyword),
            keyword: keyword,
            name: keyword
        )
    }

    private func hasRenderablePhoto(_ place: Places) -> Bool {
        guard let imageData = place.primaryPhoto?.imageData else {
            return false
        }

        return !imageData.isEmpty && UIImage(data: imageData) != nil
    }

    private func refreshCachedPlace(
        _ cachedPlace: Places,
        keyword: String,
        modelContext: ModelContext
    ) async throws {
        let places = try await service.searchByText(keyword: keyword)

        guard let place = places.first else {
            return
        }

        let photoImageData = await fetchFirstPhotoData(from: place)
        cachedPlace.placeID = place.placeID
        cachedPlace.name = place.displayName ?? keyword
        cachedPlace.address = place.formattedAddress
        cachedPlace.latitude = place.location.latitude
        cachedPlace.longitude = place.location.longitude
        cachedPlace.rating = place.rating.map(Double.init)
        cachedPlace.photos = makePlacesPhotos(
            from: place,
            photoImageData: photoImageData
        )

        try? modelContext.save()
    }

    private func fetchFirstPhotoData(from place: Place) async -> Data? {
        guard let photo = place.photos?.first else {
            return nil
        }

        do {
            let image = try await service.fetchPhoto(
                photo,
                maxSize: CGSize(width: 600, height: 700)
            )

            return image.jpegData(compressionQuality: 0.85)
        } catch {
            return nil
        }
    }

    private func makePlacesPhotos(from place: Place, photoImageData: Data?) -> [PlacesPhoto] {
        place.photos?.enumerated().map { index, photo in
            PlacesPhoto(
                reference: photo.description,
                width: Int(photo.maxSize.width),
                height: Int(photo.maxSize.height),
                imageData: index == 0 ? photoImageData : nil
            )
        } ?? []
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
