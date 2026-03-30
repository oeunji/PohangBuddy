//
//  HomeTopBarView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/30/26.
//

import SwiftUI

struct HomeTopBarView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 8, y: 4)

            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 56)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 44)
        }
        .frame(height: 140)
    }
}

#Preview {
    HomeTopBarView()
}
