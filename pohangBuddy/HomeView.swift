//
//  HomeView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/27/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("logo")
                Spacer()
            }
            .padding(.leading, 24)
            .padding(.top, 10)
            .padding(.bottom, 24)

            HStack {
                DropDownView()
                Spacer()
            }
            .padding(.horizontal, 24)

            Image("map")
                .resizable()
                .scaledToFit()
                .cornerRadius(24)
                .padding(.horizontal, 24)
                .padding(.top, 12)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("스탬프 현황")
                        .font(.title)
                    Text("10개 중 4개 채웠어요!")
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)

            StampStatusView()
                .padding(.horizontal, 24)
                .padding(.top, 16)

            Spacer()

            Button("밥 주러 가기", action: tappedStamp)
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(Color.gray.opacity(0.2))
                .foregroundStyle(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
        }
    }

    private func tappedStamp() {
        print("탭!")
    }
}

#Preview {
    HomeView()
}
