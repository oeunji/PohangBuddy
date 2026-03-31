//
//  DropDownView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/28/26.
//

import SwiftUI

struct DropDownView: View {
    @Binding var selectedOption: DropDownModel
    let options: [DropDownModel]
    
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(option.title) {
                    selectedOption = option
                }
            }
        } label: {
            HStack {
                Image("mapFlagsFull")
                    .foregroundStyle(Color.black)
                Text(selectedOption.title)
                    .foregroundStyle(Color.black)
                    .font(.head4)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundStyle(Color.black)
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 28))
        }
        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
    }
}
