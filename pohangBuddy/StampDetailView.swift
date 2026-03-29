//
//  StampDetailView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/29/26.
//

import SwiftUI

struct StampDetailView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Text("미션! 물회 먹방")
                .font(.display1)
            
            Text("포항특미물회")
                .font(.head1)
            
            Image(.물회)
                .resizable()
                .scaledToFit()
                .cornerRadius(24)
                .padding(.horizontal, 24)
                .padding(.top, 12)
            
            Spacer()
        }
        
    }
}

#Preview {
    StampDetailView()
}
