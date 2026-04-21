//
//  pohangBuddyApp.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/27/26.
//

import SwiftUI
import GooglePlacesSwift

@main
struct pohangBuddyApp: App {
    
    init() {
        guard let googleMapAPIKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_MAP_API_KEY") as? String else {
            fatalError("API Key not found")
        }
        
        _ = PlacesClient.provideAPIKey(googleMapAPIKey)
    }
    
    var body: some Scene {
        WindowGroup {
            CustomTabView()
        }
    }
}
