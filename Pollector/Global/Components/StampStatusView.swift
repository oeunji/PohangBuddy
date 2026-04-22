//
//  StampStatusView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/28/26.
//

import SwiftUI
import UIKit

struct StampStatusView: View {
    let width: CGFloat
    let places: [Places]
    let completedKeywords: Set<String>
    let onTapPlace: (Places) -> Void

    private let horizontalSpacing: CGFloat = 10
    private let verticalSpacing: CGFloat = 12

    private var cellWidth: CGFloat {
        max(0, (width - horizontalSpacing) / 2)
    }

    private var cellHeight: CGFloat {
        cellWidth * (19.0 / 18.0)
    }

    private var totalHeight: CGFloat {
        let rowCount = ceil(CGFloat(places.count) / 2.0)
        return rowCount * cellHeight + max(0, rowCount - 1) * verticalSpacing
    }

    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.fixed(cellWidth), spacing: horizontalSpacing),
                GridItem(.fixed(cellWidth))
            ],
            spacing: verticalSpacing
        ) {
            ForEach(places, id: \.cacheKey) { place in
                let isCompleted = completedKeywords.contains(place.keyword)

                Button {
                    onTapPlace(place)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.gray1)

                        cardImage(for: place.primaryPhoto)
                            .frame(width: cellWidth, height: cellHeight)
                            .saturation(isCompleted ? 1 : 0)
                            .overlay {
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        .clear,
                                        .black.opacity(0.5)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }

                        VStack(spacing: 0) {
                            Spacer()

                            HStack {
                                Text(place.keyword)
                                    .font(.head3)
                                Spacer()
                            }
                            .padding(.horizontal, 14)
                            .padding(.bottom, 4)

                            HStack {
                                Text(place.name)
                                    .font(.micro2)
                                    .lineLimit(1)
                                Spacer()
                            }
                            .padding(.horizontal, 14)
                            .padding(.bottom, 14)
                        }
                    }
                    .foregroundStyle(.white)
                    .frame(width: cellWidth, height: cellHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                .buttonStyle(.plain)
                .shadow(color: .black.opacity(0.2), radius: 8, y: 6)
            }
        }
        .frame(height: totalHeight)
    }

    @ViewBuilder
    private func cardImage(for photo: PlacesPhoto?) -> some View {
        if let imageData = photo?.imageData,
           let image = UIImage(data: imageData) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: cellWidth, height: cellHeight)
                .clipped()
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.gray1)

                Image(.imageDefault)
                    .resizable()
                    .scaledToFit()
                    .padding(36)
            }
            .frame(width: cellWidth, height: cellHeight)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        StampStatusView(
            width: geometry.size.width - 32,
            places: [
                Places(cacheKey: "preview:place", keyword: "미리보기", name: "포항 미리보기")
            ],
            completedKeywords: []
        ) { place in
            print("Tapped place: \(place.name)")
        }
        .padding(.horizontal, 16)
    }
}
