//
//  UIViewControllerExtension.swift
//  Parttime
//
//  Created by 莊文博 on 2020/3/25.
//  Copyright © 2020 Addcn. All rights reserved.
//
import UIKit
import Foundation

extension UIViewController {
    
    var childVC: [UIViewController] {
        return self.children
    }
    
    
    
    /// scrollView滑動到最上方
    func tapScrollToTop() {
        func scrollToTop(_ view: UIView?) {
            guard let view = view else { return }
            
            switch view {
            case let scrollView as UIScrollView:
                if scrollView.scrollsToTop == true {
                    // contentInset往右，x是負的
                    let point = CGPoint(x: -scrollView.contentInset.left,
                                        y: -scrollView.contentInset.top)
                    scrollView.setContentOffset(point, animated: true)
                    return
                }
            default:
                break
            }
            
            for subView in view.subviews {
                scrollToTop(subView)
            }
        }
        scrollToTop(self.view)
    }
    
    /// 取得當前頁面
    class func topVC(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topVC(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return topVC(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return topVC(base: presented)
        }
        return base
    }
    
    /// 取得navigation架構時，前一頁class名稱
    func getPreviousClassWithNaviVC() -> String {
        if let i = self.navigationController?.viewControllers.firstIndex(of: self), i > 0,
            let vc = self.navigationController?.viewControllers[i-1] {
            
            return NSStringFromClass(vc.classForCoder)
            
        } else {
            
            return "no previous_class"
        }
    }
    
}
