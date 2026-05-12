//
//  HikeDetail.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/30.
//

import SwiftUI

struct HikeDetail: View {
    var hike: Hike
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HikeDetail(hike: ModelData().hikes[0])
}
