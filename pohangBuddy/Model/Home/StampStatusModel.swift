//
//  StampStatusModel.swift
//  pohangBuddy
//
//  Created by 이은지 on 3/31/26.
//

import SwiftUI

struct StampStatusModel: Identifiable, Hashable {
    enum State: Hashable {
        case completed
        case available

        var backgroundColor: Color {
            switch self {
            case .completed:
                return .primary8
            case .available:
                return .primary4
            }
        }

        var foregroundColor: Color {
            switch self {
                default:
                    return .white
            }
        }
    }

    let id: Int
    let title: String
    let state: State
}
