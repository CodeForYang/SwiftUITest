//
//  ProfileSummary.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/5/9.
//

import SwiftUI

struct ProfileSummary: View {
    
    var profile: Profile
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10) {
                Text(profile.username).accessibilityIdentifier("summary_username")
                    .bold()
                    .font(.title)
                Text("Notifications: \(profile.perfersNotifications ? "YES" : "NO") ").accessibilityIdentifier("summary_notifications")
                Text("SeasonalPhotos: \(profile.seasonalPhoto.rawValue)").accessibilityIdentifier("summary_season")
                Text("Goal Date: \(profile.goalDate, style: .date)").accessibilityIdentifier("summary_date")
                
                Divider()
                
                ScrollView {
                    HStack {
                        HikeBadge(name: "First Hike")
                        
                        HikeBadge(name: "Earth Day")
                            .hueRotation(Angle(degrees: 90))
                        
                        HikeBadge(name: "Tenth Hike")
                            .grayscale(0.5)
                            .hueRotation(Angle(degrees: 45))
                    }
                }
                .padding(.bottom)
            }
        }
    }
}

#Preview {
    ProfileSummary(profile: Profile.default)
}
