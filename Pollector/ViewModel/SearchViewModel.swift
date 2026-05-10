//
//  SearchViewModel.swift
//  Pollector
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
    private let maxCachedPhotoCount = 3

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
        places = []

        var updatedPlaces: [Places] = []
        var latestErrorMessage: String?

        for keyword in keywords {
            let cacheKey = makeCacheKey(keyword: keyword)

            if let cachedPlace = fetchCachedPlace(cacheKey: cacheKey, modelContext: modelContext) {
                logCacheHit(keyword: keyword)
                if !needsPhotoRefresh(cachedPlace) {
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
                    continue
                }

                let cachedPlace = makeCachedPlace(
                    from: place,
                    keyword: keyword,
                    cacheKey: cacheKey,
                    photos: []
                )

                modelContext.insert(cachedPlace)
                do {
                    try modelContext.save()
                    let photoImageDataList = await fetchPhotoDataList(from: place)
                    replacePhotos(
                        on: cachedPlace,
                        with: makePlacesPhotos(from: place, photoImageDataList: photoImageDataList),
                        modelContext: modelContext
                    )
                    try modelContext.save()
                    logCacheSaved(keyword: keyword)
                } catch {
                    logCacheSaveFailure(keyword: keyword, error: error)
                }

                updatedPlaces.append(cachedPlace)
            } catch let error as NetworkError {
                latestErrorMessage = error.localizedDescription
            } catch {
                latestErrorMessage = NetworkError.unknownError.localizedDescription
            }
        }

        places = updatedPlaces
        errorMessage = latestErrorMessage
    }

    private func makeCacheKey(keyword: String) -> String {
        let normalizedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        return "pohang:\(normalizedKeyword)"
    }

    private func fetchCachedPlace(cacheKey: String, modelContext: ModelContext) -> Places? {
        var descriptor = FetchDescriptor<Places>(
            predicate: #Predicate { place in
                place.cacheKey == cacheKey
            },
            sortBy: [
                SortDescriptor(\.createdDate, order: .reverse)
            ]
        )
        descriptor.fetchLimit = 1

        do {
            if let cachedPlace = try modelContext.fetch(descriptor).first {
                return cachedPlace
            }

            return fetchCachedPlaceByScanning(cacheKey: cacheKey, modelContext: modelContext)
        } catch {
            logCacheFetchFailure(cacheKey: cacheKey, error: error)
            return fetchCachedPlaceByScanning(cacheKey: cacheKey, modelContext: modelContext)
        }
    }

    private func fetchCachedPlaceByScanning(cacheKey: String, modelContext: ModelContext) -> Places? {
        let descriptor = FetchDescriptor<Places>(
            sortBy: [
                SortDescriptor(\.createdDate, order: .reverse)
            ]
        )

        do {
            let cachedPlaces = try modelContext.fetch(descriptor)
            logCacheSnapshot(cacheKey: cacheKey, cachedPlaces: cachedPlaces)
            return cachedPlaces.first { $0.cacheKey == cacheKey }
        } catch {
            logCacheFetchFailure(cacheKey: cacheKey, error: error)
            return nil
        }
    }

    private func makeCachedPlace(
        from place: Place,
        keyword: String,
        cacheKey: String,
        photos: [PlacesPhoto]
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
            photos: photos
        )
    }

    private func needsPhotoRefresh(_ place: Places) -> Bool {
        guard !place.photos.isEmpty else {
            return true
        }

        return place.photos.contains { photo in
            guard let imageData = photo.imageData else {
                return true
            }

            return imageData.isEmpty || UIImage(data: imageData) == nil
        }
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

        let photoImageDataList = await fetchPhotoDataList(from: place)
        cachedPlace.placeID = place.placeID
        cachedPlace.name = place.displayName ?? keyword
        cachedPlace.address = place.formattedAddress
        cachedPlace.latitude = place.location.latitude
        cachedPlace.longitude = place.location.longitude
        cachedPlace.rating = place.rating.map(Double.init)
        replacePhotos(
            on: cachedPlace,
            with: makePlacesPhotos(from: place, photoImageDataList: photoImageDataList),
            modelContext: modelContext
        )

        do {
            try modelContext.save()
            logCacheSaved(keyword: keyword)
        } catch {
            logCacheSaveFailure(keyword: keyword, error: error)
        }
    }

    private func fetchPhotoDataList(from place: Place) async -> [Data?] {
        guard let photos = place.photos else {
            return []
        }

        var photoDataList: [Data?] = []

        for photo in photos.prefix(maxCachedPhotoCount) {
            do {
                let image = try await service.fetchPhoto(
                    photo,
                    maxSize: CGSize(width: 600, height: 700)
                )

                photoDataList.append(image.jpegData(compressionQuality: 0.85))
            } catch {
                photoDataList.append(nil)
            }
        }

        return photoDataList
    }

    private func makePlacesPhotos(from place: Place, photoImageDataList: [Data?]) -> [PlacesPhoto] {
        place.photos?.prefix(maxCachedPhotoCount).enumerated().map { index, photo in
            PlacesPhoto(
                reference: photo.description,
                width: Int(photo.maxSize.width),
                height: Int(photo.maxSize.height),
                imageData: photoImageDataList.indices.contains(index) ? photoImageDataList[index] : nil,
                sortIndex: index
            )
        } ?? []
    }

    private func replacePhotos(
        on cachedPlace: Places,
        with photos: [PlacesPhoto],
        modelContext: ModelContext
    ) {
        cachedPlace.photos.forEach { photo in
            modelContext.delete(photo)
        }

        photos.forEach { photo in
            modelContext.insert(photo)
        }

        cachedPlace.photos = photos
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

    private func logCacheSaved(keyword: String) {
        #if DEBUG
        print("✅ [PlacesCache] saved: \(keyword)")
        #endif
    }

    private func logCacheFetchFailure(cacheKey: String, error: Error) {
        #if DEBUG
        print("⚠️ [PlacesCache] fetch failed: \(cacheKey) | \(error)")
        #endif
    }

    private func logCacheSaveFailure(keyword: String, error: Error) {
        #if DEBUG
        print("⚠️ [PlacesCache] save failed: \(keyword) | \(error)")
        #endif
    }

    private func logCacheSnapshot(cacheKey: String, cachedPlaces: [Places]) {
        #if DEBUG
        let cacheKeys = cachedPlaces
            .prefix(8)
            .map(\.cacheKey)
            .joined(separator: ", ")

        print("🧾 [PlacesCache] lookup: \(cacheKey) | stored count: \(cachedPlaces.count) | keys: [\(cacheKeys)]")
        #endif
    }
}
