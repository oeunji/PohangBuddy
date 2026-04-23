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
    @State private var toast: FancyToast? = nil

    @Environment(\.dismiss) private var dismiss
    @State private var reviewText = ""
    @State private var selection = 0

    var body: some View {
        GeometryReader { geometry in
            let contentWidth = max(0, geometry.size.width - 32)

            ScrollView {
                ZStack(alignment: .bottom) {
                    placeImagePager
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .clipped()
                    
                    PageControl(numberOfPages: pageCount, currentPage: $selection)
                        .padding(.bottom, 16)
                }

                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(place.name)
                            .font(.display2)
                            .foregroundStyle(.neutral10)
                            .padding(.top, 16)

                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text(place.address ?? "위치 정보가 없어요")
                                .font(.body4)
                                .foregroundStyle(.neutral10)

                            Button {
                                if let address = place.address {
                                    UIPasteboard.general.string = address
                                }
                                toast = FancyToast(message: "주소를 복사했어요")
                            } label: {
                                Text("복사")
                                    .font(.micro2)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .foregroundStyle(.neutral5)
                                    .background {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.gray2)
                                    }
                            }

                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 48)
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
                    title: "기록 남기기",
                    imageName: "pencil"
                ) {
                    stampButtonTapped()
                }
                .padding(.top, 24)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .background(Color.white)
            .ignoresSafeArea()
            .toolbar(.hidden, for: .tabBar)
            .toastView(toast: $toast)
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
