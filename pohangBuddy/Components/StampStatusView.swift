//
//  StampStatusView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/28/26.
//

import SwiftUI

struct StampStatusView: View {
    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 80, maximum: 200))],
            alignment: .center) {
                ForEach(0..<11) {index in
                    Text("\(index)")
                        .foregroundStyle(Color.white)
                        .lineLimit(1)
                        .frame(width: 60, height: 60)
                        .background(RoundedRectangle(cornerRadius: 16))
                }
            }
            .foregroundStyle(Color.gray)
    }
}

#Preview {
    StampStatusView()
}
