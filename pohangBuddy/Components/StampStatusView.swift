//
//  StampStatusView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/28/26.
//

import SwiftUI

struct StampStatusView: View {
    let width: CGFloat
    let stampStatuses: [StampStatusModel]
    let onTapStamp: (Int) -> Void

    private let horizontalSpacing: CGFloat = 10
    private let verticalSpacing: CGFloat = 12

    private var cellWidth: CGFloat {
        (width - horizontalSpacing) / 2
    }

    private var cellHeight: CGFloat {
        cellWidth * (19.0 / 18.0)
    }

    private var totalHeight: CGFloat {
        let rowCount = ceil(CGFloat(stampStatuses.count) / 2.0)
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
            ForEach(stampStatuses) { stamp in
                Button {
                    onTapStamp(stamp.id)
                } label: {
                    VStack(spacing: 4) {
                        Text("\(stamp.id + 1)")
                            .font(.head4)

                        Text(stamp.title)
                            .font(.micro)
                            .lineLimit(1)
                    }
                    .foregroundStyle(stamp.state.foregroundColor)
                    .frame(width: cellWidth, height: cellHeight)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(stamp.state.backgroundColor)
                    )
                    
                }
                .buttonStyle(.plain)
                .shadow(color: .black.opacity(0.2), radius: 8, y: 6)
            }
        }
        .frame(height: totalHeight)
    }
}

#Preview {
    GeometryReader { geometry in
        StampStatusView(
            width: geometry.size.width - 32,
            stampStatuses: DropDownModel.samples[0].stampStatuses
        ) { index in
            print("Tapped stamp: \(index)")
        }
        .padding(.horizontal, 16)
    }
}
