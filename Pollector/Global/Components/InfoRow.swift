//
//  InfoRow.swift
//  Pollector
//
//  Created by 이은지 on 4/1/26.
//

import SwiftUI

struct InfoRow: View {
    let imageName: String
    let title: String
    let value: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .frame(width: 40, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.neutral5)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.head2)

                Text(value)
                    .font(.body1)
            }
            .foregroundStyle(.black)
            .padding(.horizontal, 4)

            Spacer()
        }
        .padding(.vertical, 16)
    }
}
