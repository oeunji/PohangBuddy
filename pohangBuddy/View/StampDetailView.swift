//
//  StampDetailView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/29/26.
//

import SwiftUI

struct StampDetailView: View {
    let detail: StampDetailModel
    let onStampCompleted: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var reviewText = ""
    
    // TODO: - PageControl 프로퍼티
    let array: [Color] = [.red, .green, .blue]
    @State var selection = 0

    var body: some View {
        ScrollView {
            Image(detail.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 240)
                .frame(maxWidth: .infinity)
                .clipped()
                .padding(.top, 10)
                .padding(.bottom, 16)
            
            PageControl(numberOfPages: array.count, currentPage: $selection)
                .padding(.bottom, 16)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(detail.placeName)
                        .font(.head1)
                        .foregroundStyle(.neutral10)
                        .padding(.top, 16)
                    
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.bottom, 8)
                
                HStack {
                    VStack(spacing: 0) {
                        HStack {
                            Text("현위치에서 \(detail.distanceText)")
                                .font(.body3)
                                .foregroundStyle(.neutral10)
                                .padding(.leading, 16)
                                .padding(.bottom, 8)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "pin.fill")
                                .font(.body4)
                            
                            Text("바로가기 | \(detail.address)")
                                .font(.body4)
                            
                            Text("복사")
                                .font(.micro)
                            
                            Spacer()
                        }
                        .foregroundStyle(.neutral5)
                        .padding(.leading, 16)
                        .padding(.bottom, 30)
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(detail.reviewTitle)
                        .font(.head1)
                        .foregroundStyle(.neutral10)
                        .padding(.bottom, 8)

                    Text(detail.reviewPrompt)
                        .font(.body3)
                        .foregroundStyle(.neutral5)
                }
                .padding(.leading, 16)
                .padding(.bottom, 8)
            }
            
            CustomTextView(
                text: $reviewText,
                placeholder: detail.reviewPlaceholder
            )
            .padding(.horizontal, 16)
            
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
        .background(Color.white)
    }
    
    private func stampButtonTapped() {
        onStampCompleted()
        dismiss()
    }
}

#Preview {
    StampDetailView(
        detail: DropDownModel.samples[1].stampStatuses[1].detail,
        onStampCompleted: {}
    )
}
