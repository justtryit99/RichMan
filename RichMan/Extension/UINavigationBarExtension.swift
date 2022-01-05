//
//  UINavigationBarExtension.swift
//  Parttime
//
//  Created by 莊文博 on 2021/10/6.
//  Copyright © 2021 Addcn. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationBar {
    func setBackgroundColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = color
            // 隱藏底線，兩行程式都要有
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            self.standardAppearance = appearance
            self.scrollEdgeAppearance = appearance
        } else {
            self.barTintColor = color
            // 隱藏底線，兩行程式都要有
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
        }
    }
}
