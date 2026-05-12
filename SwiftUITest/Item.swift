//
//  Item.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/28.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
