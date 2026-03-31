//
//  DropDownView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/28/26.
//

import SwiftUI

struct DropDownView: View {
    @State private var selectedOption = "어디로 갈까요?"
    
    let options = ["오늘은 맛집 데이", "오늘은 도파민 데이", "오늘은 힐링 데이", "오늘은 휴식 데이"]
    
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(option) {
                    selectedOption = option
                }
            }
        } label: {
            HStack {
                Image("mapFlagsFull")
                    .foregroundStyle(Color.black)
                Text(selectedOption)
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

#Preview {
    DropDownView()
}
