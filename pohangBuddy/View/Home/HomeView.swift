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
        VStack{
            Color.white
                .frame(height: 0)
            NavigationStack {
                ZStack {
                    VStack(spacing: 0) {
                        HomeTopBarView()
                        
                        ScrollView {
                            VStack(spacing: 12) {
                                DropDownView()
                                    .padding(.top)
                                
                                Image("map")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                    .clipShape(RoundedRectangle(cornerRadius: 36))
                            }
                            .padding(.horizontal, 24)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("스탬프 현황")
                                        .font(.head1)
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
                            .cornerRadius(36)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            
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
                    
                }
                .background(
                    Color.neutral1
                )
                .navigationDestination(item: $selectedStamp) { index in
                    StampDetailView()
                }
            }
            
        }
    }
}

#Preview {
    HomeView()
}
