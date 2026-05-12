//
//  Profile.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/5/9.
//

import Foundation

struct Profile {

    var username: String
    
    var perfersNotifications = true
    
    var seasonalPhoto = Seasons.winter
    
    var goalDate = Date()
    
    static let `default` = Profile(username: "g_kumar")
    
    enum Seasons: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"
        
        var id: String { rawValue }
    }
}
