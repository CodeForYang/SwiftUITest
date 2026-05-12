//
//  SwiftUITestApp.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/28.
//

import SwiftUI
import SwiftData

@main
struct SwiftUITestApp: App {
    @State private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
