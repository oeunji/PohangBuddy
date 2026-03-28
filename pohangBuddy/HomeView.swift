//
//  HomeView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/27/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        HStack {
            Image("logo")
                .padding(.leading, 24)
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 24)
        
        DropDownView()
        
        Image("map")
        
        Spacer()
    }
}

#Preview {
    HomeView()
}
