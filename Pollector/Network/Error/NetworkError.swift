//
//  NetworkError.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/21/26.
//

import Foundation
import GooglePlacesSwift

enum NetworkError: Error {
    case placesError(PlacesError)
    case invalidAPIKey
    case networkFail
    case unknownError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .placesError(let error):
            return "Google Places 요청에 실패했습니다: \(error)"
        case .invalidAPIKey:
            return "Google API 키를 확인해주세요."
        case .networkFail:
            return "네트워크 연결에 실패했습니다. 인터넷 상태를 확인해주세요."
        case .unknownError:
            return "알 수 없는 에러가 발생했습니다."
        }
    }
}
