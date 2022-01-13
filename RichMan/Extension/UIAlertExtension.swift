
//
//  UIAlertExtension.swift
//  Parttime
//
//  Created by 莊文博 on 2019/11/5.
//  Copyright © 2019 Addcn. All rights reserved.
//
import UIKit
import Foundation



func showAlert(title: String? = nil, msg: String? = nil, confirmHandle: ((UIAlertAction) -> Void)?) {
    let confirmAction = UIAlertAction(title: "確定", style: .default, handler: confirmHandle)
    let cancelAction = UIAlertAction(title: "取消", style: .cancel)
    
    UIAlertController.show(title: title, msg: msg,
                           style: .alert,
                           actions: [cancelAction, confirmAction])
}


extension UIAlertController {
    class func show(title: String?,
                    msg: String?,
                    style: UIAlertController.Style,
                    actions: [UIAlertAction],
                    sourceView: UIView = UIView(), 
                    isMid: Bool = false) {
        
        let VC = UIViewController.topVC()
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: style);
        for action in actions {
            alertController.addAction(action)
        }
        
        // support iPad
        if let popoverPresentationController = alertController.popoverPresentationController {
            
            if isMid {
                let x = sourceView.bounds.midX
                let y = sourceView.bounds.midY
                let rect = CGRect(x: x, y: y, width: 0, height: 0)
                popoverPresentationController.sourceView = sourceView
                popoverPresentationController.sourceRect = rect
                popoverPresentationController.permittedArrowDirections = []
            } else {
                popoverPresentationController.sourceView = sourceView
                popoverPresentationController.sourceRect = sourceView.bounds
            }
            
        }
        
        VC?.present(alertController, animated: true, completion: nil);
    }
}

extension UIAlertAction {
    class func addAction(title: String, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        let alertAction = UIAlertAction(title: title, style: style, handler: handler);
        return alertAction
    }
}

extension UIViewController {
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
}

