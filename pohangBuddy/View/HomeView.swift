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
    @StateObject private var searchViewModel = SearchViewModel()

    var body: some View {
        GeometryReader { geometry in
            let contentWidth = max(0, geometry.size.width - 32)

            ZStack {
                Color(.white)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("포항의 순간을 \n모으다")
                                .font(.display1)
                                .foregroundStyle(.neutral10)

                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.vertical, 38)

                        HStack {
                            let total = 10
                            let current = 3

                            Text("\(total)개 중 \(Text("\(current)개").font(.head3)) 모았어요")
                                .font(.head4)
                                .foregroundStyle(.neutral10)

                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 18)
                        
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(header: DropDownView(
                                selectedOption: $selectedDropDown,
                                options: DropDownModel.samples
                            )
                            .padding(.horizontal, 16)
                            .padding(.bottom, 20)
                            ) {
                                StampStatusView(
                                    width: contentWidth,
                                    stampStatuses: searchViewModel.stampStatuses
                                ) { index in
                                    selectedStamp = searchViewModel.stampStatuses.first { $0.id == index }
                                }
                                .padding(.bottom, 32)
                            }
                        }
                    }
                }
            }
        }
        .navigationDestination(item: $selectedStamp) { stamp in
            StampDetailView(
                detail: stamp.detail
            ) {
                completeStamp(withID: stamp.id)
            }
        }
        .task(id: selectedDropDown.id) {
            await searchViewModel.loadStampStatuses(for: selectedDropDown.stampStatuses)
        }
    }

    private func completeStamp(withID id: String) {
        let updatedStatuses = searchViewModel.stampStatuses.map { stamp in
            guard stamp.id == id else { return stamp }

            return StampStatusModel(
                id: stamp.id,
                title: stamp.title,
                state: .completed,
                detail: stamp.detail
            )
        }

        searchViewModel.stampStatuses = updatedStatuses

        selectedStamp = updatedStatuses.first { $0.id == id }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
