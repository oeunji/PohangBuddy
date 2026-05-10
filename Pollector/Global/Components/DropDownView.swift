//
//  DropDownView.swift
//  Pollector
//
//  Created by 이은지 on 3/28/26.
//

import SwiftUI

struct DropDownView: View {
    @Binding var selectedOption: DropDownModel
    let options: [DropDownModel]

    private let cornerRadius: CGFloat = 24
    
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(option.title) {
                    selectedOption = option
                }
            }
        } label: {
            HStack {
                Image(systemName: "pin.fill")
                Text(selectedOption.title)
                    .font(.head3)
                Spacer()
                Image(systemName: "chevron.down")
            }
            .foregroundStyle(.neutral10)
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.gray1)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
