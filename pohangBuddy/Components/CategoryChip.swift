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
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 42)
                        .fill(.ultraThinMaterial)
                    
                    if isSelected {
                        RoundedRectangle(cornerRadius: 42)
                            .fill(Color.neutral9.opacity(0.3))
                    }
                    
                    RoundedRectangle(cornerRadius: 42)
                        .stroke(.linearGradient(
                            colors: [.white.opacity(0.7), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ), lineWidth: 1.5)
                }
            )
            .foregroundColor(isSelected ? Color(.neutral1) : Color(.neutral9))
            .cornerRadius(42)
            .shadow(color: .black.opacity(0.2), radius: 8, y: 6)
            .onTapGesture(perform: action)
    }
}
