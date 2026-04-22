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
            id: "all",
            title: "전체 보기",
            stampStatuses: [
                StampStatusModel(id: "물회", title: "물회", state: .available, detail: .restaurantDayMoolhoe),
                StampStatusModel(id: "과메기", title: "과메기", state: .available, detail: .restaurantDayGwamegi),
                StampStatusModel(id: "초밥", title: "초밥", state: .available, detail: .restaurantDaySushi),
                StampStatusModel(id: "칼국수", title: "칼국수", state: .available, detail: .restaurantDayKalguksu),
                StampStatusModel(id: "국밥", title: "국밥", state: .available, detail: .restaurantDayGukbap),
                StampStatusModel(id: "분식", title: "분식", state: .available, detail: .restaurantDayBunsik),
                StampStatusModel(id: "서핑", title: "서핑", state: .available, detail: .dopamineDaySurfing),
                StampStatusModel(id: "클라이밍", title: "클라이밍", state: .available, detail: .dopamineDayNightMarket),
                StampStatusModel(id: "게임", title: "게임", state: .available, detail: .dopamineDayGame),
                StampStatusModel(id: "ATV", title: "ATV", state: .available, detail: .dopamineDayKaraoke),
                StampStatusModel(id: "요트", title: "요트", state: .available, detail: .dopamineDayBowling),
                StampStatusModel(id: "드라이브", title: "드라이브", state: .available, detail: .dopamineDayDrive),
                StampStatusModel(id: "패러글라이딩", title: "패러글라이딩", state: .available, detail: .dopamineDayExhibition),
                StampStatusModel(id: "축제", title: "축제", state: .available, detail: .dopamineDayFestival),
                StampStatusModel(id: "바다 산책", title: "바다 산책", state: .available, detail: .healingDaySeaWalk),
                StampStatusModel(id: "카페", title: "카페", state: .available, detail: .healingDayCafe),
                StampStatusModel(id: "사찰", title: "사찰", state: .available, detail: .healingDayTemple),
                StampStatusModel(id: "정원", title: "정원", state: .available, detail: .healingDayGarden),
                StampStatusModel(id: "브런치", title: "브런치", state: .available, detail: .restDayBrunch),
                StampStatusModel(id: "독서", title: "독서", state: .available, detail: .restDayReading)
            ]
        ),
        
        DropDownModel(
            id: "restaurant-day",
            title: "오늘은 맛집 데이",
            stampStatuses: [
                StampStatusModel(id: "물회", title: "물회", state: .available, detail: .restaurantDayMoolhoe),
                StampStatusModel(id: "과메기", title: "과메기", state: .available, detail: .restaurantDayGwamegi),
                StampStatusModel(id: "초밥", title: "초밥", state: .available, detail: .restaurantDaySushi),
                StampStatusModel(id: "칼국수", title: "칼국수", state: .available, detail: .restaurantDayKalguksu),
                StampStatusModel(id: "국밥", title: "국밥", state: .available, detail: .restaurantDayGukbap),
                StampStatusModel(id: "분식", title: "분식", state: .available, detail: .restaurantDayBunsik)
            ]
        ),
        DropDownModel(
            id: "dopamine-day",
            title: "오늘은 도파민 데이",
            stampStatuses: [
                StampStatusModel(id: "서핑", title: "서핑", state: .available, detail: .dopamineDaySurfing),
                StampStatusModel(id: "클라이밍", title: "클라이밍", state: .available, detail: .dopamineDayNightMarket),
                StampStatusModel(id: "게임", title: "게임", state: .available, detail: .dopamineDayGame),
                StampStatusModel(id: "ATV", title: "ATV", state: .available, detail: .dopamineDayKaraoke),
                StampStatusModel(id: "요트", title: "요트", state: .available, detail: .dopamineDayBowling),
                StampStatusModel(id: "드라이브", title: "드라이브", state: .available, detail: .dopamineDayDrive),
                StampStatusModel(id: "패러글라이딩", title: "패러글라이딩", state: .available, detail: .dopamineDayExhibition),
                StampStatusModel(id: "축제", title: "축제", state: .available, detail: .dopamineDayFestival)
            ]
        ),
        DropDownModel(
            id: "healing-day",
            title: "오늘은 힐링 데이",
            stampStatuses: [
                StampStatusModel(id: "바다 산책", title: "바다 산책", state: .available, detail: .healingDaySeaWalk),
                StampStatusModel(id: "카페", title: "카페", state: .available, detail: .healingDayCafe),
                StampStatusModel(id: "사찰", title: "사찰", state: .available, detail: .healingDayTemple),
                StampStatusModel(id: "정원", title: "정원", state: .available, detail: .healingDayGarden)
            ]
        ),
        DropDownModel(
            id: "rest-day",
            title: "오늘은 휴식 데이",
            stampStatuses: [
                StampStatusModel(id: "브런치", title: "브런치", state: .available, detail: .restDayBrunch),
                StampStatusModel(id: "독서", title: "독서", state: .available, detail: .restDayReading)
            ]
        )
    ]
}
