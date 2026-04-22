//
//  MapView.swift
//  Pollector
//
//  Created by 이은지 on 4/19/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            Map()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                CategoryScrollView()
                Spacer()
            }
        }
    }
}

#Preview {
    MapView()
}
