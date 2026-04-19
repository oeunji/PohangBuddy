//
//  CustomTabView.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/19/26.
//

import SwiftUI

struct CustomTabView: View {
    
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house") {
                HomeView()
            }
            Tab("지도", systemImage: "map") {
                MapView()
            }
        }
        .tint(.neutral6)
    }
}

#Preview {
    CustomTabView()
}
