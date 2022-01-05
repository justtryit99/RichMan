
//
//  UIAlertExtension.swift
//  Parttime
//
//  Created by 莊文博 on 2019/11/5.
//  Copyright © 2019 Addcn. All rights reserved.
//

import UIKit
import Foundation

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
