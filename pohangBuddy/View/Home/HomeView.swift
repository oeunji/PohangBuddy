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
    @State private var selectedDropDown = DropDownModel.samples[0]
    
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
                                DropDownView(
                                    selectedOption: $selectedDropDown,
                                    options: DropDownModel.samples
                                )
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
                                    Text(selectedDropDown.statusSummary)
                                        .font(.body1)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 16)
                            
                            StampStatusView(stampStatuses: selectedDropDown.stampStatuses) { index in
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
