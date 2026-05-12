//
//  FeatureCard.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/5/11.
//

import SwiftUI

struct FeatureCard: View {
    var landmark: Landmark
    var body: some View {
        landmark.featureImage?
            .resizable()
            .overlay() {
                TextOverlay(landmark: landmark)
            }
    }
}

struct TextOverlay: View {
    var landmark: Landmark
    
    var gradient: LinearGradient {
        LinearGradient(colors: [.black.opacity(0.6), .black.opacity(0)], startPoint: .bottom, endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                    .bold()
                Text(landmark.park)
            }
            .padding()
            .foregroundStyle(.white)
        } 
        .foregroundStyle(.white)
    }
}



#Preview {
    FeatureCard(landmark: ModelData().features[0])
        .aspectRatio(3 / 2, contentMode: .fit)
}
