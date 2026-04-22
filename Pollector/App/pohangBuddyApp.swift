//
//  pohangBuddyApp.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/27/26.
//

import SwiftUI
import SwiftData
import GooglePlacesSwift

@main
struct pohangBuddyApp: App {
    
    init() {
        guard
            let apiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_MAP_API_KEY") as? String,
            !apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            fatalError("GOOGLE_MAP_API_KEY가 없습니다.")
        }

        _ = PlacesClient.provideAPIKey(apiKey)
    }
    
    var body: some Scene {
        WindowGroup {
            CustomTabView()
        }
        .modelContainer(for: [
            StampListModel.self,
            Places.self,
            PlacesPhoto.self,
            StampCompletionModel.self
        ])
    }
}
