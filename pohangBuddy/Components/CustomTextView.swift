//
//  CustomTextView.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/1/26.
//

import SwiftUI

struct CustomTextView: View {
    @Binding var text: String
    var placeholder: String = "내용을 입력해주세요"

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(.gray)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    .zIndex(1)
            }

            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding(12)
                .background(Color.clear)
                .zIndex(0)
        }
        .frame(height: 198)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
