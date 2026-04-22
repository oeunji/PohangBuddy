//
//  ImagePickerView.swift
//  Pollector
//
//  Created by 이은지 on 4/20/26.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    let width: CGFloat

    private let maxImageCount = 3
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []

    private var cellSize: CGFloat {
        max(0, (width - 16) / 3)
    }

    var body: some View {
        HStack(spacing: 8) {
            if selectedImages.count < maxImageCount {
                addPhotoCell
            }

            ForEach(Array(selectedImages.enumerated()), id: \.offset) { index, image in
                removablePhotoCell(image: image, index: index)
            }
        }
        .frame(height: cellSize)
        .onChange(of: selectedItems) { _, newItems in
            Task {
                await loadSelectedImages(from: newItems)
            }
        }
    }

    private var addPhotoCell: some View {
        PhotosPicker(
            selection: $selectedItems,
            maxSelectionCount: max(0, maxImageCount - selectedImages.count),
            matching: .images
        ) {
            RoundedRectangle(cornerRadius: 18)
                .fill(.gray1)
                .frame(width: cellSize, height: cellSize)
                .overlay {
                    VStack(spacing: 8) {
                        Image(systemName: "photo.badge.plus")
                            .font(.system(size: 25))
                            .foregroundStyle(.gray5)

                        Text("\(selectedImages.count) / \(maxImageCount)")
                            .font(.head4)
                            .foregroundStyle(.gray5)
                    }
                }
        }
    }

    private func removablePhotoCell(image: UIImage, index: Int) -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: cellSize, height: cellSize)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(alignment: .topTrailing) {
                Button {
                    removeImage(at: index)
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 20))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .black.opacity(0.45))
                        .padding(12)
                }
                .buttonStyle(.plain)
            }
    }

    @MainActor
    private func loadSelectedImages(from items: [PhotosPickerItem]) async {
        let remainingCount = max(0, maxImageCount - selectedImages.count)
        guard remainingCount > 0 else {
            selectedItems = []
            return
        }

        var loadedImages: [UIImage] = []

        for item in items.prefix(remainingCount) {
            guard let data = try? await item.loadTransferable(type: Data.self),
                  let image = UIImage(data: data) else {
                continue
            }

            loadedImages.append(image)
        }

        selectedImages.append(contentsOf: loadedImages)
        selectedItems = []
    }

    private func removeImage(at index: Int) {
        guard selectedImages.indices.contains(index) else {
            return
        }

        selectedImages.remove(at: index)
    }
}
