//
//  StampDetailModel.swift
//  Pollector
//
//  Created by Codex on 4/1/26.
//

import Foundation

struct StampDetailModel: Hashable {
    let navigationTitle: String
    let imageName: String
    let placeName: String
    let address: String
    let distanceText: String
    let priceText: String
    let reviewTitle: String
    let reviewPrompt: String
    let reviewPlaceholder: String
    let actionButtonTitle: String
    let actionButtonImageName: String
}

extension StampDetailModel {
    static func make(
        navigationTitle: String,
        imageName: String,
        placeName: String,
        address: String,
        distanceText: String,
        priceText: String
    ) -> StampDetailModel {
        StampDetailModel(
            navigationTitle: navigationTitle,
            imageName: imageName,
            placeName: placeName,
            address: address,
            distanceText: distanceText,
            priceText: priceText,
            reviewTitle: "리뷰 작성하기",
            reviewPrompt: "오늘의 순간을 사진과 함께 기록해보세요",
            reviewPlaceholder: "자유롭게 기록해보세요",
            actionButtonTitle: "스탬프 받기",
            actionButtonImageName: "completeIcon"
        )
    }

    static let restaurantDayMoolhoe = make(
        navigationTitle: "미션! 물회 먹기",
        imageName: "물회",
        placeName: "포항특미물회",
        address: "경북 포항시 북구 동빈로 106",
        distanceText: "2.4km",
        priceText: "19,000원"
    )

    static let restaurantDayGwamegi = make(
        navigationTitle: "미션! 과메기 먹기",
        imageName: "과메기",
        placeName: "엘토르원조구룡포과메기",
        address: "경북 포항시 북구 죽도로40번길 7-1",
        distanceText: "8.1km",
        priceText: "30,000원"
    )

    static let restaurantDaySushi = make(
        navigationTitle: "미션! 초밥 먹기",
        imageName: "초밥",
        placeName: "가정초밥 효자본점",
        address: "경북 포항시 남구 효자동길2번길 3 효자역전종합상가 1층",
        distanceText: "1.2km",
        priceText: "14,800원"
    )

    static let restaurantDayKalguksu = make(
        navigationTitle: "미션! 칼국수 먹기",
        imageName: "칼국수",
        placeName: "포항홍게칼국수",
        address: "경북 포항시 북구 해안로 185 1층",
        distanceText: "2.8km",
        priceText: "11,000원"
    )

    static let restaurantDayGukbap = make(
        navigationTitle: "미션! 국밥 먹기",
        imageName: "국밥",
        placeName: "용강돼지국밥",
        address: "경북 포항시 남구 대이로175번길 17-12 1층",
        distanceText: "2.0km",
        priceText: "10,000원"
    )

    static let restaurantDayBunsik = make(
        navigationTitle: "미션! 분식 먹기",
        imageName: "분식",
        placeName: "햇살머믄꼬마김밥 이동점",
        address: "경북 포항시 남구 대이로 143",
        distanceText: "2.1km",
        priceText: "7,000원"
    )

    static let dopamineDaySurfing = make(
        navigationTitle: "미션! 서핑 즐기기",
        imageName: "서핑",
        placeName: "딥인더웨이브",
        address: "경북 포항시 북구 해안로 385-4 1층 Deep in the wave",
        distanceText: "2.2km",
        priceText: "60,000원"
    )

    static let dopamineDayNightMarket = make(
        navigationTitle: "미션! 클라이밍 즐기기",
        imageName: "클라이밍",
        placeName: "아띠클라이밍",
        address: "경북 포항시 북구 우창동로 70 테라스31 지하1층 아띠클라이밍",
        distanceText: "6.2km",
        priceText: "25,000원"
    )

    static let dopamineDayGame = make(
        navigationTitle: "미션! 서바이벌 게임 즐기기",
        imageName: "서바이벌게임",
        placeName: "레이저아레나 포항점",
        address: "경북 포항시 북구 중앙상가길 21",
        distanceText: "7.2km",
        priceText: "10,000원"
    )

    static let dopamineDayBowling = make(
        navigationTitle: "미션! 요트 타기",
        imageName: "요트",
        placeName: "박선장 요트투어",
        address: "경북 포항시 북구 두호동 1017",
        distanceText: "7.8km",
        priceText: "32,000원"
    )

    static let dopamineDayDrive = make(
        navigationTitle: "미션! 드라이브 하기",
        imageName: "호미곶",
        placeName: "호미곶 해안도로",
        address: "경북 포항시 남구 호미곶면 해맞이로 150번길 20",
        distanceText: "27.4km",
        priceText: "20,000원"
    )

    static let dopamineDayExhibition = make(
        navigationTitle: "미션! 페러글라이딩 즐기기",
        imageName: "패러글라이딩",
        placeName: "포항 패러글라이딩체험센터",
        address: "경북 포항시 북구 흥해읍 해안로 1366-42 포항곤륜산패러글라이딩체험센터",
        distanceText: "15km",
        priceText: "55,000원"
    )

    static let dopamineDayFestival = make(
        navigationTitle: "미션! 축제 즐기기",
        imageName: "축제",
        placeName: "포항 운하 축제광장",
        address: "경북 포항시 남구 희망대로 1040",
        distanceText: "5.2km",
        priceText: "무료"
    )

    static let healingDaySeaWalk = make(
        navigationTitle: "미션! 바다 산책하기",
        imageName: "바다",
        placeName: "영일대 해변 산책로",
        address: "경북 포항시 북구 두호동 685-1",
        distanceText: "3.1km",
        priceText: "무료"
    )

    static let healingDayCafe = make(
        navigationTitle: "미션! 카페 가기",
        imageName: "카페",
        placeName: "오브레멘",
        address: "경북 포항시 북구 해안로 191-1 오브레멘",
        distanceText: "4.0km",
        priceText: "6,500원"
    )

    static let healingDayTemple = make(
        navigationTitle: "미션! 사찰 가기",
        imageName: "보경사",
        placeName: "보경사",
        address: "경북 포항시 북구 송라면 보경로 523",
        distanceText: "26.0km",
        priceText: "무료"
    )

    static let healingDayGarden = make(
        navigationTitle: "미션! 정원 산책하기",
        imageName: "환호공원",
        placeName: "환호공원",
        address: "경북 포항시 북구 환호공원길 30",
        distanceText: "4.9km",
        priceText: "무료"
    )

    static let restDayStay = make(
        navigationTitle: "미션! 숙소에서 쉬기",
        imageName: "map",
        placeName: "포항 호텔뷰",
        address: "경북 포항시 북구 해안로 265",
        distanceText: "3.3km",
        priceText: "120,000원"
    )

    static let restDayBrunch = make(
        navigationTitle: "미션! 브런치 먹기",
        imageName: "브런치",
        placeName: "인브리즈",
        address: "경북 포항시 북구 장량로 140 인브리즈 (1, 2층)",
        distanceText: "3.6km",
        priceText: "18,000원"
    )

    static let restDayReading = make(
        navigationTitle: "미션! 독서하기",
        imageName: "도서관",
        placeName: "포항시립영암도서관",
        address: "경북 포항시 남구 상공로 46번길 11",
        distanceText: "4.4km",
        priceText: "무료"
    )
}
