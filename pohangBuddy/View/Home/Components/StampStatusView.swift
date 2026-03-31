//
//  StampStatusView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/28/26.
//

import SwiftUI

struct StampStatusView: View {
    let onTapStamp: (Int) -> Void

    var body: some View {
        ZStack {
            LazyVGrid(
                columns: Array(repeating: GridItem(.fixed(60), spacing: 24), count: 4),
                spacing: 18
            ) {
                ForEach(0..<11) { index in
                    Button {
                        onTapStamp(index)
                    } label: {
                        Text("\(index)")
                            .foregroundStyle(Color.white)
                            .lineLimit(1)
                            .frame(width: 64, height: 64)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color("stampBackgroundColor"))
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical)
            .background(
                Color("stampColor")
            )
        }
    }
}

#Preview {
    NavigationStack {
        StampStatusView { index in
            print(index)
        }
    }
}
