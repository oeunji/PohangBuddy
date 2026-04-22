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
    @State private var feedRemainingCount: Int
    @State private var loveRemainingCount: Int
    @State private var fishOffsetY: CGFloat = 10
    @State private var currentFishImageName = "fishNormal"
    @State private var fishReactionToken = UUID()

    init(actionCount: Int = 0) {
        _feedRemainingCount = State(initialValue: actionCount)
        _loveRemainingCount = State(initialValue: actionCount)
    }

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
                    Image(currentFishImageName)
                        .offset(x: 0, y: fishOffsetY)
                        .frame(height: 220)
                        .onAppear {
                            withAnimation(
                                .easeInOut(duration: 1.0)
                                .repeatForever(autoreverses: true)
                            ) {
                                fishOffsetY = -10
                            }
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
                            subtitle: "\(feedRemainingCount)회 남았어요",
                            isEnabled: feedRemainingCount > 0
                        ) {
                            feedFish()
                        }

                        FishActionCard(
                            image: .fishLove,
                            title: "쓰담쓰담",
                            subtitle: "\(loveRemainingCount)회 남았어요",
                            isEnabled: loveRemainingCount > 0
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
        guard feedRemainingCount > 0 else { return }

        feedRemainingCount -= 1
        showTemporaryFishImage("fishEat")
        increaseLevelProgress()
    }

    private func loveFish() {
        guard loveRemainingCount > 0 else { return }

        loveRemainingCount -= 1
        showTemporaryFishImage("fishHappy")
        increaseLevelProgress()
    }

    private func increaseLevelProgress() {
        let nextProgress = levelProgress + 0.10

        if nextProgress >= 1.0 {
            level += 1
            levelProgress = 0
        } else {
            levelProgress = nextProgress
        }
    }

    private func showTemporaryFishImage(_ imageName: String) {
        let token = UUID()
        fishReactionToken = token
        currentFishImageName = imageName

        Task {
            try? await Task.sleep(for: .seconds(1))

            guard fishReactionToken == token else { return }
            currentFishImageName = "fishNormal"
        }
    }
}

#Preview {
    FishCareView(actionCount: 2)
}
