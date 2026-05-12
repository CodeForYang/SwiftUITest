//
//  CategoryHome.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/30.
//

import SwiftUI

struct CategoryHome: View {
    @Environment(ModelData.self) private var modelData
    @State private var showingProfile = false
    
    var body: some View {
        NavigationSplitView {
            List {
                PageView(pages: modelData.features.map{ FeatureCard(landmark: $0) })
                    .listRowInsets(EdgeInsets())
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                        .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(.inset)
            .navigationTitle("Feature")
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environment(modelData)
            }
        } detail: {
            Text("Select a Landmark")
        }

    }
}

#Preview {
    CategoryHome().environment(ModelData())
}
