//
//  HomeView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/27/26.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedStamp: Int?
    @State private var showModal = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HomeTopBarView()
                    
                    VStack(spacing: 12) {
                        DropDownView()

                        Image("map")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                    .padding(.horizontal, 24)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("스탬프 현황")
                                .font(.head2)
                            Text("10개 중 4개 채웠어요!")
                                .font(.body1)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    
                    StampStatusView { index in
                        selectedStamp = index
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    
                    Spacer()
                    
                    FishCareButton {
                        showModal = true
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    .sheet(isPresented: $showModal) {
                        FishCareView()
                    }
                }
                .background(
                    Color("backgroundColor")
                        .edgesIgnoringSafeArea(.bottom)
                )
            }

            .navigationDestination(item: $selectedStamp) { index in
                StampDetailView()
            }
        }
    }
}

#Preview {
    HomeView()
}
