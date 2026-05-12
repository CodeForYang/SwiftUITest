//
//  CategoryItem.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/30.
//

import SwiftUI

struct CategoryItem: View {
    var landmark: Landmark
    var body: some View {
        VStack {
            landmark.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(landmark.name)
                .font(.caption)
                .foregroundStyle(.primary)
        }
        .padding(.leading, 15)
        
    }
}

#Preview {
    let landmark = ModelData().landmarks[1]
    CategoryItem(landmark: landmark)
}
