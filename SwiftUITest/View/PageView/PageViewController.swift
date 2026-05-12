//
//  PageViewController.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/5/11.
//

import UIKit
import SwiftUI

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    
    var pages: [Page]
    
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }
    
   
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        return pageViewController
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
            controllers = parent.pages.map{ UIHostingController(rootView: $0) }
        }
        
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let idx = controllers.firstIndex(of: viewController) else { return nil }
            
            return  idx == 0 ? controllers.last : controllers[idx - 1]
            
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let idx = controllers.firstIndex(of: viewController) else { return nil }
            
            return  idx == controllers.count - 1 ? controllers.first : controllers[idx + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
            //pageViewController.viewControllers?.first 为当前显示的 Vc
            //previousViewControllers 是转换之后的Vc，如果中途取消滑动，则值同上
            if completed {
                guard let visibleVc = pageViewController.viewControllers?.first else { return }
                guard let idx = controllers.firstIndex(of: visibleVc) else { return }
                parent.currentPage = idx
            }
        }
    }
}

