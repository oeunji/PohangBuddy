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
                Color("backgroundColor")
                    .ignoresSafeArea()
                
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
