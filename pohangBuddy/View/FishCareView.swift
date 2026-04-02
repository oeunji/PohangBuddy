//
//  FishCareView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/29/26.
//

import SwiftUI

struct FishCareView: View {

    @Environment(\.dismiss) private var dismissView
    @State private var level = 1
    @State private var levelProgress = 0.0
    @State private var isAnimating = false

    private var remainingPercentText: String {
        let remainingPercent = Int((1 - levelProgress) * 100)
        return "레벨업까지 \(remainingPercent)% 남았어요"
    }
        
    var body: some View {
        NavigationStack {
            ZStack {
                Image("ocean")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                                
                VStack(spacing: 0) {
                    Image("fishNormal")
                        .offset(y: isAnimating ? -10 : 10)
                        .animation(
                            Animation.easeInOut(duration: 1.0)
                                .repeatForever(autoreverses: true),
                            value: isAnimating
                        )
                        .onAppear {
                            isAnimating = true
                        }
                        .onDisappear {
                            isAnimating = false
                        }

                    Text("Level \(level)")
                        .padding()
                        .font(.display1)
                    
                    VStack(alignment: .trailing) {
                        ProgressView(value: levelProgress)
                            .tint(.yellow)
                            .scaleEffect(x: 1, y: 3)
                        
                        Text(remainingPercentText)
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
        increaseLevelProgress()
    }

    private func loveFish() {
        increaseLevelProgress()
    }

    private func increaseLevelProgress() {
        let nextProgress = levelProgress + 0.05

        if nextProgress >= 1.0 {
            level += 1
            levelProgress = 0
        } else {
            levelProgress = nextProgress
        }
    }
}

#Preview {
    FishCareView()
}
