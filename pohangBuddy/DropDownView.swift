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
                Text(selectedOption)
                    .foregroundStyle(Color.black)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundStyle(Color.black)
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }

}

#Preview {
    DropDownView()
}
