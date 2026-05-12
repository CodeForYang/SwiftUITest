//
//  ContentView.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/28.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }

    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem({
                    Label("Featured", systemImage: "star")
                }).tag(Tab.featured)
            
            LandmarkList()
                .tabItem({
                    Label("list", systemImage: "list.bullet")
                })
                .tag(Tab.list)
        }   
    }
}

#Preview {
    ContentView().environment(ModelData())
}
