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
                    .font(.display1)
                
                VStack(alignment: .trailing) {
                    ProgressView(value: levelProgress)
                    
                    Text("레벨업까지 50% 남았어요")
                        .font(.body3)
                        .padding(.top, 4)
                }
                .padding()
                .padding(.horizontal, 24)

                
                HStack(spacing: 32) {
                    VStack {
                        Button(action: {
                            feedFish()
                        }, label: {
                            Image(.fishFood)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                        })
                        
                        Text("밥 주기")
                            .font(.head2)
                            .padding(.top, 4)
                        
                        Text("1회 남았어요")
                            .font(.head3)
                            .padding(.top, 1)
                    }
                    .padding(.vertical, 4)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 36)
                            .fill(Color.white)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 4)

                    VStack {
                        Button(action: {
                            loveFish()
                        }, label: {
                            Image(.fishLove)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                        })
                        
                        Text("쓰담쓰담")
                            .font(.head2)
                            .padding(.top, 4)
                        
                        Text("1회 남았어요")
                            .font(.head3)
                            .padding(.top, 1)
                    }
                    .padding(.vertical, 4)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 36)
                            .fill(Color.white)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
                }
                .padding(.top, 8)
                
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
