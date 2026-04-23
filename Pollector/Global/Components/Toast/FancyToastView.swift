//
//  FancyToastView.swift
//  Pollector
//
//  Created by 이은지 on 4/23/26.
//

import SwiftUI

struct FancyToastView: View {
    var message: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(message)
                        .font(.body1)
                        .foregroundColor(.neutral10)
                }
                
                Spacer(minLength: 10)
            }
            .padding(.all, 18)
        }
        .background(.white)
        .overlay(
            Rectangle()
                .fill(.neutral5)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}

#Preview {
    FancyToastView(message: "메시지")
}
