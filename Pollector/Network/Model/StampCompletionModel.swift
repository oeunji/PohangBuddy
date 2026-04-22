//
//  StampCompletionModel.swift
//  pohangBuddy
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
    var completedDate: Date

    init(
        keyword: String,
        placeCacheKey: String,
        placeID: String? = nil,
        placeName: String,
        completedDate: Date = Date()
    ) {
        self.id = StampCompletionModel.makeID(keyword: keyword)
        self.keyword = keyword
        self.placeCacheKey = placeCacheKey
        self.placeID = placeID
        self.placeName = placeName
        self.completedDate = completedDate
    }

    static func makeID(keyword: String) -> String {
        "stamp-completion:\(keyword)"
    }
}
