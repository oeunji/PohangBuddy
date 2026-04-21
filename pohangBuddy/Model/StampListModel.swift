//
//  StampListModel.swift
//  pohangBuddy
//
//  Created by 이은지 on 4/21/26.
//

import Foundation
import SwiftData

@Model
class StampListModel {
    var photoData: Data?
    var title: String
    var shopName: String
    
    init(photoData: Data? = nil,
         title: String,
         shopName: String) {
        self.photoData = photoData
        self.title = title
        self.shopName = shopName
    }
}
