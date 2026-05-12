//
//  LandmarkList.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/28.
//

import SwiftUI

struct LandmarkList: View {
    
    @Environment(ModelData.self) var modelData
    @State private var isShowFavorite = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!isShowFavorite || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            
            List {
                Toggle("Favorites only", isOn: $isShowFavorite)
                
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            
            .navigationTitle("Landmarks")
        } detail: {
            Text("Select a landmark")
        }
        
    }
}

#Preview {
    LandmarkList().environment(ModelData())
}
