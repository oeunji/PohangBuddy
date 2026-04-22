//
//  GradientActionButton.swift
//  Pollector
//
//  Created by 이은지 on 3/30/26.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let imageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label {
                Text(title)
                    .font(.head3)
            } icon: {
                Image(imageName)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(.neutral3)
            )
            .shadow(color: Color.blue.opacity(0.3), radius: 8, y: 4)
        }
        .buttonStyle(.plain)
    }
}
