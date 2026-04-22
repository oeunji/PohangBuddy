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
                Button {
                    onTapPlace(place)
                } label: {
                    ZStack {
                        cardImage(
                            for: place.photos.first
                        )
                            .frame(width: cellWidth, height: cellHeight)
                            .cornerRadius(24)
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
                                    .font(.micro)
                                    .lineLimit(1)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 14)
                            .padding(.bottom, 14)
                        }
                    }
                    .foregroundStyle(.white)
                    .frame(width: cellWidth, height: cellHeight)
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
            Image(.normalmage)
                .resizable()
                .scaledToFill()
                .frame(width: cellWidth, height: cellHeight)
                .clipped()
        }
    }
}

#Preview {
    GeometryReader { geometry in
        StampStatusView(
            width: geometry.size.width - 32,
            places: [
                Places(cacheKey: "preview:place", keyword: "미리보기", name: "포항 미리보기")
            ]
        ) { place in
            print("Tapped place: \(place.name)")
        }
        .padding(.horizontal, 16)
    }
}
