//
//  ModelType.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/21/26.
//

import Foundation

/// 요청 DTO용
protocol RequestModelType: Encodable {}

/// 응답 DTO용
protocol ResponseModelType: Decodable {}

/// 응답이 필요 없는 경우 사용하는 모델
struct EmptyResponseDTO: ResponseModelType { }
