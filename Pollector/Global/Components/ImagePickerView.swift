//
//  ImagePickerView.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/20/26.
//

import SwiftUI

struct ImagePickerView: View {
    let width: CGFloat

    private let maxImageCount = 3
    @State private var selectedImageCount = 2

    private var cellSize: CGFloat {
        max(0, (width - 16) / 3)
    }

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<maxImageCount, id: \.self) { index in
                if index == 0 {
                    addPhotoCell
                } else {
                    removablePhotoCell
                }
            }
        }
        .frame(height: cellSize)
    }

    private var addPhotoCell: some View {
        RoundedRectangle(cornerRadius: 18)
            .fill(.gray1)
            .frame(width: cellSize, height: cellSize)
            .overlay {
                VStack(spacing: 8) {
                    Image(systemName: "photo.badge.plus")
                        .font(.system(size: 25))
                        .foregroundStyle(.gray5)

                    Text("\(selectedImageCount) / \(maxImageCount)")
                        .font(.head4)
                        .foregroundStyle(.gray5)
                }
            }
    }

    private var removablePhotoCell: some View {
        RoundedRectangle(cornerRadius: 18)
            .fill(.gray1)
            .frame(width: cellSize, height: cellSize)
            .overlay(alignment: .topTrailing) {
                Button {
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 20))
                        .foregroundStyle(.gray5)
                        .padding(12)
                }
            }
    }
}
