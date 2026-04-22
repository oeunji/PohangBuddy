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
}

extension DropDownModel {
    private static let restaurantKeywords = [
        "물회",
        "과메기",
        "초밥",
        "칼국수",
        "국밥",
        "분식",
        "돈까스"
    ]

    private static let dopamineKeywords = [
        "서핑",
        "클라이밍",
        "서바이벌게임",
        "요트",
        "드라이브",
        "패러글라이딩",
        "축제"
    ]

    private static let healingKeywords = [
        "바다 산책",
        "카페",
        "사찰",
        "공원"
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
            title: "맛집 한 끼",
            keywords: restaurantKeywords
        ),
        DropDownModel(
            id: "dopamine-day",
            title: "짜릿한 하루",
            keywords: dopamineKeywords
        ),
        DropDownModel(
            id: "healing-day",
            title: "느긋한 시간",
            keywords: healingKeywords
        ),
        DropDownModel(
            id: "rest-day",
            title: "쉬어가는 하루",
            keywords: restKeywords
        )
    ]
}
