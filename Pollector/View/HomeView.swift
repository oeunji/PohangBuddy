//
//  HomeView.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/27/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedPlace: Places?
    @State private var showsPlaceDetail = false
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
                            Text("포항의 \n순간을 모으다")
                                .font(.display1)
                                .foregroundStyle(.neutral10)

                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.vertical, 38)

                        HStack {
                            let total = selectedDropDown.keywords.count
                            let current = searchViewModel.places.count

                            Text("\(total)개 중 \(Text("\(current)개").font(.head5)) 모았어요")
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
                                    places: searchViewModel.places
                                ) { place in
                                    selectedPlace = place
                                    showsPlaceDetail = true
                                }
                                .padding(.bottom, 32)
                            }
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $showsPlaceDetail) {
            if let selectedPlace {
                StampDetailView(place: selectedPlace) {
                    showsPlaceDetail = false
                }
            }
        }
        .task(id: selectedDropDown.id) {
            await searchViewModel.loadPlaces(
                for: selectedDropDown.keywords,
                modelContext: modelContext
            )
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
