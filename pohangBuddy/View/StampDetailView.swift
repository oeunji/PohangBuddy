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

    let array: [Color] = [.red, .green, .blue]
    @State var selection = 0
    
    @State private var isBookmarked = false

    var body: some View {
        GeometryReader { geometry in
            let contentWidth = max(0, geometry.size.width - 32)

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
                                Button {
                                    print("바로가기 클릭")
                                } label: {
                                    HStack(spacing: 4) {
                                        Image(systemName: "pin.fill")
                                            .font(.body4)
                                            .frame(width: 13, height: 13)

                                        Text("바로가기")
                                            .font(.body4)
                                    }
                                }

                                Text(detail.address)
                                    .font(.body4)

                                Button {
                                    print("복사")
                                } label: {
                                    Text("복사")
                                        .font(.micro)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background {
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(Color.gray2)
                                        }
                                }

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
                            .font(.micro1)
                            .foregroundStyle(.gray5)
                            .padding(.bottom, 8)

                        Text(Date().koreanDateString)
                            .font(.body4)
                            .foregroundStyle(.neutral10)
                            .padding(.bottom, 8)

                        ImagePickerView(width: contentWidth)
                    }
                    .padding(.horizontal, 16)
                }

                CustomTextView(
                    text: $reviewText,
                    placeholder: detail.reviewPlaceholder
                )
                .padding(.horizontal, 16)

                ActionButton(
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
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                Button {
                    isBookmarked.toggle()
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                }
            }
        }
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
