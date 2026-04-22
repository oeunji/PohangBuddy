//
//  PageControl.swift
//  Pollector
//
//  Created by 이은지 on 4/20/26.
//

import SwiftUI

struct PageControl: View {
    
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { pagingIndex in
                let isCurrentPage = currentPage == pagingIndex
                let height = 8.0
                let width = isCurrentPage ? height * 2 : height
                
                Capsule()
                    .fill(isCurrentPage ? Color.neutral8 : Color.neutral3)
                    .frame(width: width, height: height)
            }
        }
        .animation(.linear, value: currentPage)
    }
}
