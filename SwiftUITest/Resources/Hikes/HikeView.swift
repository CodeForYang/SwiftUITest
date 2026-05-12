//
//  HikeView.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/30.
//

import SwiftUI


extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}


struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)
                
                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.title)
                    Text(hike.distanceText)
                }
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 4)) {
                        showDetail.toggle()
                    }
                    
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .animation(.easeInOut, value: showDetail)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                }

            }
            
            if showDetail {
                HikeDetail(hike: hike)
            }
        }
    }
}

#Preview {
    HikeView(hike: ModelData().hikes[0])
}
