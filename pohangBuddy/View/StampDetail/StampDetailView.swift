//
//  StampDetailView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/29/26.
//

import SwiftUI

struct StampDetailView: View {
    let detail: StampDetailModel
    @State private var reviewText = ""

    var body: some View {
        ScrollView {
            Image(detail.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(36)
                .padding(.horizontal, 24)
                .padding(.top, 24)
            
            Text(detail.placeName)
                .font(.head1)
                .padding(.top, 16)
            
            VStack(spacing: 0) {
                InfoRow(
                    imageName: "mapFlagsFull",
                    title: "주소",
                    value: detail.address
                )

                Divider()

                InfoRow(
                    imageName: "route",
                    title: "거리",
                    value: detail.distanceText
                )

                Divider()

                InfoRow(
                    imageName: "money",
                    title: "예상 비용",
                    value: detail.priceText
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
                    Text(detail.reviewTitle)
                        .font(.head1)

                    Text(detail.reviewPrompt)
                        .font(.body3)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 32)
                .padding(.top, 16)
                
                Spacer()
            }
            
            CustomTextView(
                text: $reviewText,
                placeholder: detail.reviewPlaceholder
            )
            .padding(.horizontal, 24)
            
            GradientActionButton(
                title: detail.actionButtonTitle,
                imageName: detail.actionButtonImageName
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
    StampDetailView(detail: DropDownModel.samples[0].stampStatuses[0].detail)
}
