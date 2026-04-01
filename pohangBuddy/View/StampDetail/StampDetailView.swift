//
//  StampDetailView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/29/26.
//

import SwiftUI

struct StampDetailView: View {
    @State private var reviewText = ""

    var body: some View {
        ScrollView {
            Image(.물회)
                .resizable()
                .scaledToFit()
                .cornerRadius(36)
                .padding(.horizontal, 24)
                .padding(.top, 24)
            
            Text("포항특미물회")
                .font(.head1)
                .padding(.top, 16)
            
            VStack(spacing: 0) {
                InfoRow(
                    imageName: "mapFlagsFull",
                    title: "주소",
                    value: "경북 포항시 북구 동빈로 106"
                )

                Divider()

                InfoRow(
                    imageName: "route",
                    title: "거리",
                    value: "2.4km"
                )

                Divider()

                InfoRow(
                    imageName: "money",
                    title: "예상 비용",
                    value: "19,000원"
                )
            }
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.white)
            )
            .padding(.horizontal, 24)
            .padding(.vertical, 4)
            .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("리뷰 작성하기")
                        .font(.head1)

                    Text("오늘의 경험을 남겨보세요")
                        .font(.body3)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 32)
                .padding(.top, 16)
                
                Spacer()
            }
            
            CustomTextView(
                text: $reviewText,
                placeholder: "자유롭게 기록해보세요"
            )
            .padding(.horizontal, 24)
            
            GradientActionButton(
                title: "스탬프 찍기",
                imageName: "completeIcon"
            ) {
                stampButtonTapped()
            }
            .padding(.top, 24)
            .padding(.horizontal, 24)
            .padding(.bottom, 24)

        }
        .background(
            Color.neutral1
                .ignoresSafeArea(.all)
        )
    }
    
    private func stampButtonTapped() {
        
    }
}

#Preview {
    StampDetailView()
}
