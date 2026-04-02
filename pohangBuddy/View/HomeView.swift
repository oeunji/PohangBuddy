//
//  HomeView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/27/26.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedStamp: StampStatusModel?
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
                                selectedStamp = selectedDropDown.stampStatuses.first { $0.id == index }
                            }
                            .cornerRadius(36)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 16)
                            
                            GradientActionButton(
                                title: "밥 주러 가기",
                                imageName: "meal"
                            ) {
                                showModal = true
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 24)
                            .sheet(isPresented: $showModal) {
                                FishCareView(actionCount: selectedDropDown.completedCount)
                            }
                        }
                    }
                    
                }
                .background(
                    Color.neutral1
                )
                .navigationDestination(item: $selectedStamp) { stamp in
                    StampDetailView(
                        detail: stamp.detail,
                        onStampCompleted: {
                            completeStamp(withID: stamp.id)
                        }
                    )
                        .navigationTitle(stamp.detail.navigationTitle)
                }
            }
            
        }
    }

    private func completeStamp(withID id: Int) {
        let updatedStatuses = selectedDropDown.stampStatuses.map { stamp in
            guard stamp.id == id else { return stamp }

            return StampStatusModel(
                id: stamp.id,
                title: stamp.title,
                state: .completed,
                detail: stamp.detail
            )
        }

        selectedDropDown = DropDownModel(
            id: selectedDropDown.id,
            title: selectedDropDown.title,
            stampStatuses: updatedStatuses
        )

        selectedStamp = updatedStatuses.first { $0.id == id }
    }
}

#Preview {
    HomeView()
}
