//
//  FavoriteButton.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/29.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .orange : .gray)
        }
        
    }
}

#Preview {
    FavoriteButton(isSet: .constant(true))
}
