//
//  StampDetailView.swift
//  Pollector
//
//  Created by 이은지 on 3/29/26.
//

import SwiftUI
import UIKit

struct StampDetailView: View {
    let place: Places
    let onStampCompleted: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var reviewText = ""
    @State private var selection = 0
    @State private var isBookmarked = false

    var body: some View {
        GeometryReader { geometry in
            let contentWidth = max(0, geometry.size.width - 32)

            ScrollView {
                placeImagePager
                    .frame(height: 240)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .padding(.top, 10)
                    .padding(.bottom, 16)

                PageControl(numberOfPages: pageCount, currentPage: $selection)
                    .padding(.bottom, 16)

                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(place.name)
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
                                Text(place.address ?? "위치 정보가 없어요")
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

                                Text(place.address ?? "위치 정보가 없어요")
                                    .font(.body4)

                                Button {
                                    print("복사")
                                } label: {
                                    Text("복사")
                                        .font(.micro2)
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
                        Text("리뷰 작성하기")
                            .font(.head1)
                            .foregroundStyle(.neutral10)
                            .padding(.bottom, 8)

                        Text("오늘의 순간을 사진과 함께 기록해보세요")
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
                    placeholder: "자유롭게 기록해보세요"
                )
                .padding(.horizontal, 16)

                ActionButton(
                    title: "스탬프 받기",
                    imageName: "completeIcon"
                ) {
                    stampButtonTapped()
                }
                .padding(.top, 24)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .background(Color.white)
            .toolbar(.hidden, for: .tabBar)
        }
    }

    private func stampButtonTapped() {
        onStampCompleted()
        dismiss()
    }

    @ViewBuilder
    private var placeImagePager: some View {
        let imageItems = placeImageItems

        TabView(selection: $selection) {
            if imageItems.isEmpty {
                fallbackPlaceImage
                    .tag(0)
            } else {
                ForEach(Array(imageItems.enumerated()), id: \.element.id) { index, item in
                    Image(uiImage: item.image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .tag(index)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    private var pageCount: Int {
        max(placeImageItems.count, 1)
    }

    private var placeImageItems: [PlaceImageItem] {
        place.sortedPhotos.compactMap { photo in
            guard let imageData = photo.imageData,
                  let image = UIImage(data: imageData) else {
                return nil
            }

            return PlaceImageItem(
                id: "\(photo.sortIndexValue)-\(photo.reference)",
                image: image
            )
        }
    }

    private var fallbackPlaceImage: some View {
        Image(.imageDefault)
            .resizable()
            .scaledToFill()
    }
}

private struct PlaceImageItem {
    let id: String
    let image: UIImage
}

extension PlaceImageItem: Identifiable {}

#Preview {
    StampDetailView(
        place: Places(
            cacheKey: "preview:place",
            keyword: "미리보기",
            name: "포항 미리보기",
            address: "경북 포항시"
        ),
        onStampCompleted: {}
    )
}
