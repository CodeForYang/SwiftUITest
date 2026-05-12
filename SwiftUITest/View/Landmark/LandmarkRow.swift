//
//  LandmarkRow.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/28.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    
    var body: some View {
        
        HStack {
            landmark.image.resizable()
                .frame(width: 50, height: 50)
            
            Text(landmark.name)
            
            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill").foregroundStyle(.orange)
            }
            
        }
    }
}

#Preview {
    let landmarks = ModelData().landmarks
    Group {
        LandmarkRow(landmark: landmarks[0])

        LandmarkRow(landmark: landmarks[1])

        LandmarkRow(landmark: landmarks[2])

        LandmarkRow(landmark: landmarks[3])
    }
}
