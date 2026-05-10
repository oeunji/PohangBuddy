//
//  StampDetailView.swift
//  Pollector
//
//  Created by 이은지 on 3/29/26.
//

import SwiftUI
import UIKit
import SwiftData

struct StampDetailView: View {
    let place: Places
    let onSaved: () -> Void
    private let reviewSectionID = "review-section"
    private let actionButtonID = "action-button"

    @Environment(\.modelContext) private var modelContext
    @State private var toast: FancyToast? = nil

    @Environment(\.dismiss) private var dismiss
    @State private var reviewText = ""
    @State private var selection = 0
    @State private var selectedImages: [UIImage] = []
    @State private var hasCompletedRecord: Bool
    @State private var keyboardHeight: CGFloat = 0
    @FocusState private var isReviewFieldFocused: Bool
    private let maxReviewLength = 500

    init(place: Places, isCompleted: Bool, onSaved: @escaping () -> Void = {}) {
        self.place = place
        self.onSaved = onSaved
        _hasCompletedRecord = State(initialValue: isCompleted)
    }

    var body: some View {
        GeometryReader { geometry in
            let contentWidth = max(0, geometry.size.width - 32)
            let keyboardInset = keyboardHeight

            ScrollViewReader { proxy in
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
                            Text("기록 작성하기")
                                .font(.head1)
                                .foregroundStyle(.neutral10)
                                .padding(.bottom, 8)

                            Text("오늘의 순간을 사진과 함께 기록해보세요")
                                .font(.micro1)
                                .foregroundStyle(.gray5)
                                .padding(.bottom, 8)
                            
                            ImagePickerView(
                                width: contentWidth,
                                selectedImages: $selectedImages,
                                isLocked: hasCompletedRecord
                            )
                            .padding(.bottom, 8)
                            
                            HStack {
                                Text("\(Date().koreanDateString)에 방문")
                                    .foregroundStyle(.neutral10)
                                
                                Spacer()
                                
                                Text("\(reviewText.count) / \(maxReviewLength)")
                                    .foregroundStyle(.neutral7)
                            }
                            .font(.body4)
                            .padding(.horizontal, 6)
                            .padding(.bottom, 8)
                        }
                        .padding(.horizontal, 16)
                    }

                    CustomTextView(
                        text: $reviewText,
                        placeholder: "자유롭게 기록해보세요",
                        isDisabled: hasCompletedRecord,
                        isFocused: $isReviewFieldFocused
                    )
                    .id(reviewSectionID)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)

                    ActionButton(
                        title: hasCompletedRecord ? "기록 완료" : "기록 남기기",
                        imageName: "pencil",
                        backgroundColor: hasCompletedRecord ? Color.gray8 : Color.neutral4,
                        isDisabled: hasCompletedRecord
                    ) {
                        stampButtonTapped()
                    }
                    .id(actionButtonID)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32 + keyboardInset)
                }
                .scrollDismissesKeyboard(.interactively)
                .background(Color.white)
                .ignoresSafeArea()
                .toolbar(.hidden, for: .tabBar)
                .toastView(toast: $toast)
                .onChange(of: reviewText) { _, newValue in
                    guard newValue.count > maxReviewLength else { return }
                    reviewText = String(newValue.prefix(maxReviewLength))
                }
                .onChange(of: isReviewFieldFocused) { _, isFocused in
                    guard isFocused else { return }
                    scrollToEditor(using: proxy)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                    updateKeyboardHeight(with: notification, safeAreaBottom: geometry.safeAreaInsets.bottom)
                    guard isReviewFieldFocused else { return }
                    scrollToEditor(using: proxy)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    keyboardHeight = 0
                }
                .task(id: place.keyword) {
                    loadSavedCompletion()
                }
            }
        }
    }

    private func stampButtonTapped() {
        guard !hasCompletedRecord else { return }

        let trimmedReviewText = reviewText.trimmingCharacters(in: .whitespacesAndNewlines)
        let photoModels = selectedImages.enumerated().compactMap { item -> StampCompletionPhoto? in
            let (index, image) = item

            guard let imageData = image.jpegData(compressionQuality: 0.85) else {
                return nil
            }

            return StampCompletionPhoto(imageData: imageData, sortIndex: index)
        }

        for photoModel in photoModels {
            modelContext.insert(photoModel)
        }

        let completionID = StampCompletionModel.makeID(keyword: place.keyword)
        let descriptor = FetchDescriptor<StampCompletionModel>(
            predicate: #Predicate { completion in
                completion.id == completionID
            }
        )

        if let existingCompletion = try? modelContext.fetch(descriptor).first {
            existingCompletion.placeCacheKey = place.cacheKey
            existingCompletion.placeID = place.placeID
            existingCompletion.placeName = place.name
            existingCompletion.reviewText = trimmedReviewText
            existingCompletion.completedDate = Date()

            for photo in existingCompletion.photos {
                modelContext.delete(photo)
            }

            existingCompletion.photos = photoModels
        } else {
            let completion = StampCompletionModel(
                keyword: place.keyword,
                placeCacheKey: place.cacheKey,
                placeID: place.placeID,
                placeName: place.name,
                reviewText: trimmedReviewText,
                photos: photoModels
            )

            modelContext.insert(completion)
        }

        try? modelContext.save()
        hasCompletedRecord = true
        onSaved()
        dismiss()
    }

    private func loadSavedCompletion() {
        let completionID = StampCompletionModel.makeID(keyword: place.keyword)
        let descriptor = FetchDescriptor<StampCompletionModel>(
            predicate: #Predicate { completion in
                completion.id == completionID
            }
        )

        guard let completion = try? modelContext.fetch(descriptor).first else {
            return
        }

        reviewText = String((completion.reviewText ?? "").prefix(maxReviewLength))
        selectedImages = completion.sortedPhotos.compactMap { photo in
            UIImage(data: photo.imageData)
        }
        hasCompletedRecord = true
    }

    private func scrollToEditor(using proxy: ScrollViewProxy) {
        withAnimation(.easeInOut(duration: 0.25)) {
            proxy.scrollTo(actionButtonID, anchor: .bottom)
        }
    }

    private func updateKeyboardHeight(with notification: Notification, safeAreaBottom: CGFloat) {
        guard
            let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }

        keyboardHeight = max(0, keyboardFrame.height - safeAreaBottom)
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
        isCompleted: false
    )
}
