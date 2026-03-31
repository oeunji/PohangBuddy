//
//  FishCareButton.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/30/26.
//

import SwiftUI

struct FishCareButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label {
                Text("밥 주러 가기")
            } icon: {
                Image("meal")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .foregroundStyle(Color.white)
            .font(.head3)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(Color.blue.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
}

#Preview {
    FishCareButton(action: {})
}
