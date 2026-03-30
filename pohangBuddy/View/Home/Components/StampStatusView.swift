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
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 80, maximum: 200))],
            alignment: .center
        ) {
            ForEach(0..<11) { index in
                Button {
                    onTapStamp(index)
                } label: {
                    Text("\(index)")
                        .foregroundStyle(Color.white)
                        .lineLimit(1)
                        .frame(width: 60, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.gray)
                        )
                }
                .buttonStyle(.plain)
            }
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
