//
//  PageControl.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/5/12.
//

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
    
    var numberOfPages:Int
    @Binding var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        return control
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
        uiView.addTarget(
            context.coordinator,
            action: #selector(Coordinator.clickPageControl(sender:)),
            for: .valueChanged)
    }
    
    
    class Coordinator: NSObject {
        var pageControl: PageControl
        
        init(_ pageControl: PageControl) {
            self.pageControl = pageControl
        }
        
        @objc
        func clickPageControl(sender: UIPageControl) {
            pageControl.currentPage = sender.currentPage
        }
    }
    
}
