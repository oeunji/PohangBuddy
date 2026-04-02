//
//  FishActionCard.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/1/26.
//

import SwiftUI

struct FishActionCard: View {
    let image: ImageResource
    let title: String
    let subtitle: String
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        VStack {
            Button(action: action) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
            }
            .disabled(!isEnabled)

            Text(title)
                .font(.head2)
                .padding(.top, 4)

            Text(subtitle)
                .font(.head3)
                .padding(.top, 1)
        }
        .padding(.vertical, 4)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 36)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
        .opacity(isEnabled ? 1 : 0.45)
    }
}
