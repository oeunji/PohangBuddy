//
//  StampStatusView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/28/26.
//

import SwiftUI

struct StampStatusView: View {
    let stampStatuses: [StampStatusModel]
    let onTapStamp: (Int) -> Void

    var body: some View {
        ZStack {
            LazyVGrid(
                columns: Array(repeating: GridItem(.fixed(60), spacing: 24), count: 4),
                spacing: 18
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
                            .lineLimit(1)
                            .frame(width: 64, height: 64)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(stamp.state.backgroundColor)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical)
            .background(
                Color.primary2
            )
        }
    }
}

#Preview {
    NavigationStack {
        StampStatusView(stampStatuses: DropDownModel.samples[0].stampStatuses) { index in
            print(index)
        }
    }
}
