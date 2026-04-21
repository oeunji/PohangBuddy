//
//  SearchViewModel.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/21/26.
//

import Foundation
import Combine
import GooglePlacesSwift

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var stampStatuses: [StampStatusModel] = []
    @Published var errorMessage: String?

    private let service: PlacesServicing

    init(service: PlacesServicing) {
        self.service = service
    }

    convenience init() {
        self.init(service: PlacesService())
    }

    func search(keyword: String) async {
        do {
            places = try await service.searchByText(keyword: keyword)
            errorMessage = nil
        } catch let error as NetworkError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = NetworkError.unknownError.localizedDescription
        }
    }

    func loadStampStatuses(for baseStatuses: [StampStatusModel]) async {
        stampStatuses = baseStatuses

        var updatedStatuses: [StampStatusModel] = []
        var latestErrorMessage: String?

        for status in baseStatuses {
            do {
                let places = try await service.searchByText(keyword: status.title)

                guard let place = places.first else {
                    updatedStatuses.append(status)
                    continue
                }

                updatedStatuses.append(
                    StampStatusModel(
                        id: place.displayName ?? status.id,
                        title: status.title,
                        state: status.state,
                        detail: StampDetailModel(
                            navigationTitle: "미션! \(status.title)",
                            imageName: status.detail.imageName,
                            placeName: place.displayName ?? status.detail.placeName,
                            address: place.formattedAddress ?? status.detail.address,
                            distanceText: status.detail.distanceText,
                            priceText: status.detail.priceText,
                            reviewTitle: status.detail.reviewTitle,
                            reviewPrompt: status.detail.reviewPrompt,
                            reviewPlaceholder: status.detail.reviewPlaceholder,
                            actionButtonTitle: status.detail.actionButtonTitle,
                            actionButtonImageName: status.detail.actionButtonImageName
                        )
                    )
                )
            } catch let error as NetworkError {
                latestErrorMessage = error.localizedDescription
                updatedStatuses.append(status)
            } catch {
                latestErrorMessage = NetworkError.unknownError.localizedDescription
                updatedStatuses.append(status)
            }
        }

        stampStatuses = updatedStatuses
        errorMessage = latestErrorMessage
    }
}
