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
            
            HStack {
                VStack {
                    Button(action: {
                        feedFish()
                    }, label: {
                        Image(.fishFood)
                            .imageScale(.large)
                            .font(.largeTitle)
                            .foregroundStyle(Color.black)
                    })
                    
                    Text("밥 주기")
                    
                    Text("1회 남았어요")
                }

                VStack {
                    Button(action: {
                        loveFish()
                    }, label: {
                        Image(.fishLove)
                            .imageScale(.large)
                            .font(.largeTitle)
                            .foregroundStyle(Color.black)
                    })
                    
                    Text("밥 주기")
                    
                    Text("1회 남았어요")
                }
            }
            
            Spacer()
        }
    }
    
    private func feedFish() {
        
    }
    
    private func loveFish() {
        
    }
}

#Preview {
    FishCareView()
}
