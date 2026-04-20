//
//  CategoryChip.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/20/26.
//

import SwiftUI

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Text(title)
            .font(.head4)
            .padding(.all, 14)
            .background(isSelected ? Color(.neutral9) : Color(.neutral1))
            .foregroundColor(isSelected ? Color(.neutral1) : Color(.neutral9))
            .cornerRadius(42)
        
            .shadow(color: .black.opacity(0.2), radius: 8, y: 6)
            .onTapGesture(perform: action)
        
    }
}

#Preview {
    CategoryChip(title: "전체 보기", isSelected: false, action: temp)
}

func temp() {}
