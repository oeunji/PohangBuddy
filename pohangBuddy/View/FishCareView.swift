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
        NavigationStack {
            VStack(spacing: 0) {
                Image("fishNormal")

                Text("Level 1")
                    .padding()
                
                VStack(alignment: .trailing) {
                    ProgressView(value: levelProgress)
                    
                    Text("레벨업까지 50% 남았어요")
                }
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
            .background(Color.neutral1)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismissView()
                    } label: {
                        Image(systemName: "xmark")
                            .frame(width: 32, height: 32)
                            .background(.regularMaterial, in: Circle())
                    }
                }
            }
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
