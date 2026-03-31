//
//  HomeTopBarView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/30/26.
//

import SwiftUI

struct HomeTopBarView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 52)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity)
        .background(
            Color.white
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 36,
                        bottomTrailingRadius: 36,
                        topTrailingRadius: 0
                    )
                )
                .shadow(color: .black.opacity(0.06), radius: 10, y: 4)
        )
    }
}

#Preview {
    HomeTopBarView()
}
