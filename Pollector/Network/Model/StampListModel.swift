//
//  StampListModel.swift
//  Pollector
//
//  Created by 이은지 on 4/21/26.
//

import Foundation
import SwiftData

@Model
class StampListModel {
    var title: String              // 표시용 제목
    var shopName: String           // 가게 이름
    var photoData: Data?           // 실제 이미지 데이터
    var keyword: String            // 검색 키워드 (물회, 과메기 등)
    var placeID: String?           // Google Places 고유 ID (중복 방지용)
    var address: String?           // 주소
    var latitude: Double?          // 위도
    var longitude: Double?         // 경도
    var rating: Double?            // 평점
    var photoReference: String?    // 사진 참조 ID (나중에 로드용)
    var createdDate: Date          // 저장 날짜
    
    init(title: String,
         shopName: String,
         keyword: String,
         placeID: String? = nil,
         address: String? = nil,
         latitude: Double? = nil,
         longitude: Double? = nil,
         rating: Double? = nil,
         photoReference: String? = nil,
         photoData: Data? = nil,
         createdDate: Date = Date()) {
        self.title = title
        self.shopName = shopName
        self.keyword = keyword
        self.placeID = placeID
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.rating = rating
        self.photoReference = photoReference
        self.photoData = photoData
        self.createdDate = createdDate
    }
}
