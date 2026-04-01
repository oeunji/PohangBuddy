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
                StampStatusModel(id: 0, title: "물회", state: .completed, detail: .restaurantDayMoolhoe),
                StampStatusModel(id: 1, title: "과메기", state: .completed, detail: .restaurantDayGwamegi),
                StampStatusModel(id: 2, title: "초밥", state: .completed, detail: .restaurantDaySushi),
                StampStatusModel(id: 3, title: "칼국수", state: .available, detail: .restaurantDayKalguksu),
                StampStatusModel(id: 4, title: "국밥", state: .available, detail: .restaurantDayGukbap),
                StampStatusModel(id: 5, title: "분식", state: .available, detail: .restaurantDayBunsik)
            ]
        ),
        DropDownModel(
            id: "dopamine-day",
            title: "오늘은 도파민 데이",
            stampStatuses: [
                StampStatusModel(id: 0, title: "서핑", state: .completed, detail: .dopamineDaySurfing),
                StampStatusModel(id: 1, title: "클라이밍", state: .available, detail: .dopamineDayNightMarket),
                StampStatusModel(id: 2, title: "게임", state: .available, detail: .dopamineDayGame),
                StampStatusModel(id: 3, title: "ATV", state: .available, detail: .dopamineDayKaraoke),
                StampStatusModel(id: 4, title: "요트", state: .available, detail: .dopamineDayBowling),
                StampStatusModel(id: 5, title: "드라이브", state: .available, detail: .dopamineDayDrive),
                StampStatusModel(id: 6, title: "패러글라이딩", state: .available, detail: .dopamineDayExhibition),
                StampStatusModel(id: 7, title: "축제", state: .available, detail: .dopamineDayFestival)
            ]
        ),
        DropDownModel(
            id: "healing-day",
            title: "오늘은 힐링 데이",
            stampStatuses: [
                StampStatusModel(id: 0, title: "바다 산책", state: .completed, detail: .healingDaySeaWalk),
                StampStatusModel(id: 1, title: "카페", state: .completed, detail: .healingDayCafe),
                StampStatusModel(id: 2, title: "사찰", state: .completed, detail: .healingDayTemple),
                StampStatusModel(id: 3, title: "정원", state: .completed, detail: .healingDayGarden)
            ]
        ),
        DropDownModel(
            id: "rest-day",
            title: "오늘은 휴식 데이",
            stampStatuses: [
                StampStatusModel(id: 0, title: "브런치", state: .available, detail: .restDayBrunch),
                StampStatusModel(id: 1, title: "독서", state: .available, detail: .restDayReading)
            ]
        )
    ]
}
