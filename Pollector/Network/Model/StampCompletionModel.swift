//
//  StampCompletionModel.swift
//  Pollector
//
//  Created by Codex on 4/22/26.
//

import Foundation
import SwiftData

@Model
final class StampCompletionModel {
    @Attribute(.unique) var id: String
    var keyword: String
    var placeCacheKey: String
    var placeID: String?
    var placeName: String
    var reviewText: String?
    var completedDate: Date

    @Relationship(deleteRule: .cascade)
    var photos: [StampCompletionPhoto]

    init(
        keyword: String,
        placeCacheKey: String,
        placeID: String? = nil,
        placeName: String,
        reviewText: String? = nil,
        photos: [StampCompletionPhoto] = [],
        completedDate: Date = Date()
    ) {
        self.id = StampCompletionModel.makeID(keyword: keyword)
        self.keyword = keyword
        self.placeCacheKey = placeCacheKey
        self.placeID = placeID
        self.placeName = placeName
        self.reviewText = reviewText
        self.photos = photos
        self.completedDate = completedDate
    }

    static func makeID(keyword: String) -> String {
        "stamp-completion:\(keyword)"
    }
}

extension StampCompletionModel {
    var sortedPhotos: [StampCompletionPhoto] {
        photos.sorted { lhs, rhs in
            lhs.sortIndex < rhs.sortIndex
        }
    }
}

@Model
final class StampCompletionPhoto {
    var imageData: Data
    var sortIndex: Int

    init(imageData: Data, sortIndex: Int) {
        self.imageData = imageData
        self.sortIndex = sortIndex
    }
}
