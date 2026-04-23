//
//  CustomTextView.swift
//  Pollector
//
//  Created by 이은지 on 4/1/26.
//

import SwiftUI

struct CustomTextView: View {
    @Binding var text: String
    var placeholder: String = "내용을 입력해주세요"
    var isDisabled: Bool = false
    var isFocused: FocusState<Bool>.Binding?

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(.micro1)
                    .foregroundStyle(.gray5)
                    .padding(.top, 18)
                    .padding(.leading, 18)
                    .zIndex(1)
            }

            if let isFocused {
                TextEditor(text: $text)
                    .focused(isFocused)
                    .font(.body4)
                    .scrollContentBackground(.hidden)
                    .padding(10)
                    .background(Color.clear)
                    .disabled(isDisabled)
                    .zIndex(0)
            } else {
                TextEditor(text: $text)
                    .font(.body4)
                    .scrollContentBackground(.hidden)
                    .padding(10)
                    .background(Color.clear)
                    .disabled(isDisabled)
                    .zIndex(0)
            }
        }
        .frame(height: 198)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
    }
}
