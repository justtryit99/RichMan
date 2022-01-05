//
//  UIApplicationExtension.swift
//  Parttime
//
//  Created by 莊文博 on 2019/9/26.
//  Copyright © 2019 Addcn. All rights reserved.
//
import UIKit
import Foundation

extension UIApplication {
    
    // 目前ios 13 更改statusBar background color還是無效 9/26
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 987654321
            if let statusBar = self.keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag
                
                self.keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}
