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
}
