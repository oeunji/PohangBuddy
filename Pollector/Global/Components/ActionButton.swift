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
    var backgroundColor: Color = .neutral4
    var isDisabled: Bool = false
    let action: () -> Void

    init(
        title: String,
        imageName: String,
        backgroundColor: Color = .neutral4,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.imageName = imageName
        self.backgroundColor = backgroundColor
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Label {
                Text(title)
                    .font(.head3)
            } icon: {
                Image(systemName: imageName)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(backgroundColor)
            )
            .shadow(color: Color.black.opacity(0.3), radius: 8, y: 4)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.9 : 1)
        .buttonStyle(.plain)
    }
}
