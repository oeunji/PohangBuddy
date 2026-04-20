//
//  Font+Extension.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/28/26.
//

import SwiftUI

extension Font {
    static let display1: Font = .custom("Pretendard-Bold", size: 28)
    static let display2: Font = .custom("Pretendard-SemiBold", size: 24)

    static let head1: Font = .custom("Pretendard-SemiBold", size: 20)   // 주요 타이틀, 카드 타이틀
    static let head2: Font = .custom("Pretendard-Medium", size: 18)     // 상세 페이지 제목
    static let head3: Font = .custom("Pretendard-SemiBold", size: 17)     // 상세 페이지 제목
    static let head4: Font = .custom("Pretendard-Medium", size: 16)     // 카드 소제목, 네비게이션 타이틀
    static let head5: Font = .custom("Pretendard-SemiBold", size: 15)

    static let body1: Font = .custom("Pretendard-Regular", size: 15)    // 일반 본문
    static let body3: Font = .custom("Pretendard-Medium", size: 14)     //
    static let body4: Font = .custom("Pretendard-Regular", size: 13)     //

//    static let caption: Font = .custom("Pretendard-Regular", size: 13)  // 시간 정보, 태그, 단위, 날짜 등 작은 설명

    static let micro: Font = .custom("Pretendard-Regular", size: 11)    // 버튼 라벨, 보조 문구 (툴팁 등)
}
