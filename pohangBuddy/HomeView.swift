//
//  HomeView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/27/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        HStack {
            Image("logo")
                .padding(.leading, 24)
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 24)
        
        HStack {
            DropDownView()
                .padding(.leading, 24)
            Spacer()
        }
        
        Image("map")
        
        HStack {
            VStack(alignment: .leading) {
                Text("스탬프 현황")
                    .font(.title)
                Text("10개 중 4개 채웠어요!")
            }
            .padding(.leading, 24)
            
            Spacer()
        }
        
        StampStatusView()
            .padding(.horizontal, 24)
        
        
        Spacer()
    }
}

#Preview {
    HomeView()
}
