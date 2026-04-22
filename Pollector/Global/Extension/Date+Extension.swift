//
//  Date+Extension.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/20/26.
//

import Foundation

extension Date {
    var koreanDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter.string(from: self)
    }
}
