//
//  CategoryScrollView.swift
//  Pollector
//
//  Created by 이은지 on 4/20/26.
//

import SwiftUI

struct CategoryScrollView: View {
    @State private var selectedCategory = "전체 보기"

    private let rows = [GridItem(.fixed(30))]
    private let content = ["전체 보기", "🍴맛집", "🏃 도파민", "🌿 힐링", "☕️ 휴식"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 12) {
                ForEach(content, id: \.self) { category in
                    CategoryChip(
                        title: category,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 60)
    }
}
