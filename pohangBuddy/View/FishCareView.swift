//
//  FishCareView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/29/26.
//

import SwiftUI

struct FishCareView: View {

    @Environment(\.dismiss) private var dismissView
    @State private var levelProgress = 0.5

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    dismissView()
                }, label: {
                    Image(systemName: "x.circle")
                        .imageScale(.large)
                        .font(.largeTitle)
                        .foregroundStyle(Color.black)
                })
                    
                Spacer()
            }
            
            Image("fishNormal")

            Text("Level 1")
                .padding()
            
            ProgressView(value: levelProgress)
                .padding()
            
            
            
            Spacer()
            
            Text("밥 주러 왔다!")
        }
    }
}

#Preview {
    FishCareView()
}
