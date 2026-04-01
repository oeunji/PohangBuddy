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
            ZStack {
                Image("ocean")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                                
                VStack(spacing: 0) {
                    Image("fishNormal")

                    Text("Level 1")
                        .padding()
                        .font(.display1)
                    
                    VStack(alignment: .trailing) {
                        ProgressView(value: levelProgress)
                            .tint(.yellow)
                            .scaleEffect(x: 1, y: 3)
                        
                        Text("레벨업까지 50% 남았어요")
                            .font(.body3)
                            .padding(.top, 8)
                    }
                    .padding()
                    .padding(.horizontal, 24)

                    HStack(spacing: 16) {
                        FishActionCard(
                            image: .fishFood,
                            title: "밥 주기",
                            subtitle: "1회 남았어요"
                        ) {
                            feedFish()
                        }

                        FishActionCard(
                            image: .fishLove,
                            title: "쓰담쓰담",
                            subtitle: "1회 남았어요"
                        ) {
                            loveFish()
                        }
                    }
                    .padding(.top, 8)
                    
                    Spacer()
                }

            }
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
