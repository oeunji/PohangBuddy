//
//  BaseResponseBody.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/21/26.
//

import Foundation

/// 공통 응답 DTO
struct BaseResponseBody<T: ResponseModelType>: ResponseModelType {
    let success: Bool
    let code: String
    let message: String
    let data: T?
}
