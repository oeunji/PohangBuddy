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
        GeometryReader { geometry in
            let contentWidth = geometry.size.width - 32

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
                            Text("10개 중 3개 모았어요")
                                .font(.head3)
                                .foregroundStyle(.neutral10)

                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 18)
                        
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(header:                         DropDownView(
                                selectedOption: $selectedDropDown,
                                options: DropDownModel.samples
                            )
                            .padding(.horizontal, 16)
                            .padding(.bottom, 20)
                            ) {
                                StampStatusView(
                                    width: contentWidth,
                                    stampStatuses: selectedDropDown.stampStatuses
                                ) { index in
                                    selectedStamp = selectedDropDown.stampStatuses.first { $0.id == index }
                                }
                                .padding(.bottom, 32)
                            }
                        }
                    }
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
