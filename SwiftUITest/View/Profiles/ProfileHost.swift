//
//  ProfileHost.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/5/9.
//

import SwiftUI

struct ProfileHost: View {
    
    @State private var draftProfile = Profile.default
    @Environment(ModelData.self) var modelData
    @Environment(\.editMode) var editMode
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                
                Spacer()
                
                EditButton().accessibilityIdentifier("editButton")
                
            }
            
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear() {
                        draftProfile = modelData.profile
                    }
                    .onDisappear() {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ProfileHost().environment(ModelData())
}
