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
    let keywords: [String]

    var statusSummary: String {
        "\(keywords.count)개를 둘러볼 수 있어요!"
    }
}

extension DropDownModel {
    private static let restaurantKeywords = [
        "물회",
        "과메기",
        "초밥",
        "칼국수",
        "국밥",
        "분식"
    ]

    private static let dopamineKeywords = [
        "서핑",
        "클라이밍",
        "게임",
        "ATV",
        "요트",
        "드라이브",
        "패러글라이딩",
        "축제"
    ]

    private static let healingKeywords = [
        "바다 산책",
        "카페",
        "사찰",
        "정원"
    ]

    private static let restKeywords = [
        "브런치",
        "독서"
    ]

    static let samples: [DropDownModel] = [
        DropDownModel(
            id: "all",
            title: "전체 보기",
            keywords: restaurantKeywords + dopamineKeywords + healingKeywords + restKeywords
        ),
        
        DropDownModel(
            id: "restaurant-day",
            title: "오늘은 맛집 데이",
            keywords: restaurantKeywords
        ),
        DropDownModel(
            id: "dopamine-day",
            title: "오늘은 도파민 데이",
            keywords: dopamineKeywords
        ),
        DropDownModel(
            id: "healing-day",
            title: "오늘은 힐링 데이",
            keywords: healingKeywords
        ),
        DropDownModel(
            id: "rest-day",
            title: "오늘은 휴식 데이",
            keywords: restKeywords
        )
    ]
}
