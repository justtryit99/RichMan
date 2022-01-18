
//
//  UIAlertExtension.swift
//  Parttime
//
//  Created by 莊文博 on 2019/11/5.
//  Copyright © 2019 Addcn. All rights reserved.
//
import UIKit
import Foundation



func showAlert(title: String? = nil, confirmHandle: ((UIAlertAction) -> Void)?) {
    let confirmAction = UIAlertAction(title: "確定", style: .default, handler: confirmHandle)
    let cancelAction = UIAlertAction(title: "取消", style: .cancel)
    
    
    UIAlertController.show(title: title, msg: nil,
                           style: .alert,
                           actions: [cancelAction, confirmAction])
}


extension UIAlertController {
    class func show(title: String?,
                    msg: String? = nil,
                    style: UIAlertController.Style,
                    actions: [UIAlertAction],
                    sourceView: UIView = UIView(), 
                    isMid: Bool = false) {
        
        let VC = UIViewController.topVC()
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: style)
        
        alertController.setTint(color: .black)
        alertController.setTitlet(font: UIFont.systemFont(ofSize: 26, weight: .medium),
                                  color: nil)
        
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
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    //Set title font and title color
        func setTitlet(font: UIFont?, color: UIColor?) {
            guard let title = self.title else { return }
            let attributeString = NSMutableAttributedString(string: title)//1
            if let titleFont = font {
//                print("title.utf8: \(title.utf8)")
                attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                              range: NSMakeRange(0, title.count))
            }
            
            if let titleColor = color {
                attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                              range: NSMakeRange(0, title.count))
            }
            self.setValue(attributeString, forKey: "attributedTitle")//4
        }
        
        //Set message font and message color
        func setMessage(font: UIFont?, color: UIColor?) {
            guard let message = self.message else { return }
            let attributeString = NSMutableAttributedString(string: message)
            if let messageFont = font {
                attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                              range: NSMakeRange(0, message.count))
            }
            
            if let messageColorColor = color {
                attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                              range: NSMakeRange(0, message.count))
            }
            self.setValue(attributeString, forKey: "attributedMessage")
        }
        
        //Set tint color of UIAlertController
        func setTint(color: UIColor) {
            self.view.tintColor = color
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

