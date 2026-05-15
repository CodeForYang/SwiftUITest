//
//  ProfileEditor.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/5/9.
//

import SwiftUI

struct ProfileEditor: View {
    
    @Binding var profile: Profile
    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let startComponents = calendar.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let endComponents = calendar.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return startComponents...endComponents
    }
    
    var body: some View {
        List {
            HStack {
                Text("Username")
                Spacer()
                TextField("Username", text: $profile.username)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            
            Toggle("Enable Notifications", isOn: $profile.perfersNotifications)
                .accessibilityIdentifier("Enable Notifications")
            
            Picker("Season Photos", selection: $profile.seasonalPhoto) {
                ForEach(Profile.Seasons.allCases) { season in
                    Text(season.rawValue).tag(season)
                }
            }
            
            DatePicker("Goal Date", selection: $profile.goalDate, in: dateRange, displayedComponents: .date)
                .accessibilityIdentifier("Goal Date")
        }
    }
}

#Preview {
    ProfileEditor(profile: .constant(.default))
}
