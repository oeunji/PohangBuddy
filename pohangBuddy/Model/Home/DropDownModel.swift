//
//  DropDownModel.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/31/26.
//

import Foundation

struct DropDownModel: Identifiable, Hashable {
    let id: String
    let title: String
    let stampStatuses: [StampStatusModel]

    var completedCount: Int {
        stampStatuses.filter { $0.state == .completed }.count
    }

    var statusSummary: String {
        "\(stampStatuses.count)개 중 \(completedCount)개 채웠어요!"
    }
}

extension DropDownModel {
    static let samples: [DropDownModel] = [
        DropDownModel(
            id: "restaurant-day",
            title: "오늘은 맛집 데이",
            stampStatuses: [
                StampStatusModel(id: 0, title: "물회", state: .completed),
                StampStatusModel(id: 1, title: "과메기", state: .completed),
                StampStatusModel(id: 2, title: "초밥", state: .completed),
                StampStatusModel(id: 3, title: "칼국수", state: .available),
                StampStatusModel(id: 4, title: "국밥", state: .available),
                StampStatusModel(id: 5, title: "분식", state: .available)
            ]
        ),
        DropDownModel(
            id: "dopamine-day",
            title: "오늘은 도파민 데이",
            stampStatuses: [
                StampStatusModel(id: 0, title: "서핑", state: .completed),
                StampStatusModel(id: 1, title: "야시장", state: .available),
                StampStatusModel(id: 2, title: "게임", state: .available),
                StampStatusModel(id: 3, title: "노래방", state: .available),
                StampStatusModel(id: 4, title: "볼링", state: .available),
                StampStatusModel(id: 5, title: "드라이브", state: .available),
                StampStatusModel(id: 6, title: "전시", state: .available),
                StampStatusModel(id: 7, title: "축제", state: .available)
            ]
        ),
        DropDownModel(
            id: "healing-day",
            title: "오늘은 힐링 데이",
            stampStatuses: [
                StampStatusModel(id: 0, title: "바다 산책", state: .completed),
                StampStatusModel(id: 1, title: "카페", state: .completed),
                StampStatusModel(id: 2, title: "사찰", state: .completed),
                StampStatusModel(id: 3, title: "정원", state: .completed)
            ]
        ),
        DropDownModel(
            id: "rest-day",
            title: "오늘은 휴식 데이",
            stampStatuses: [
                StampStatusModel(id: 0, title: "숙소", state: .available),
                StampStatusModel(id: 1, title: "브런치", state: .available),
                StampStatusModel(id: 2, title: "독서", state: .available)
            ]
        )
    ]
}
