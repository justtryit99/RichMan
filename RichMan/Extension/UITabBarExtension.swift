//
//  UITabBarExtension.swift
//  Parttime
//
//  Created by 李俊賢 on 2018/4/30.
//  Copyright © 2018年 Addcn. All rights reserved.
//

import UIKit

extension UITabBar {
    override open var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UITraitCollection(horizontalSizeClass: .compact)
        }
        return super.traitCollection
    }
    
    func showBadge(index:Int) {
        self.removeBadge(index: index)
        
        let badgeView = UIView()
        badgeView.tag = 518 + index
        badgeView.layer.cornerRadius = 4
        badgeView.backgroundColor = ORANGE_COLOR
        
        let itemCount = self.items?.count ?? 4
        if let item = self.items?[safe: index] {
            let itemWidth = self.frame.size.width / CGFloat(itemCount)
            let itemImageWidth = item.image?.size.width ?? 0
            let itemImagePadding = ((itemWidth - itemImageWidth) / 2) + 5
            badgeView.frame = CGRect(x:(itemWidth * (CGFloat(index)+1)) - itemImagePadding, y:5, width:8, height:8)
            self.addSubview(badgeView)
        }
    }
    
    func hideBadge(index:Int) {
        self.removeBadge(index: index)
    }
    
    fileprivate func removeBadge(index:Int) {
        for view in self.subviews {
            if view.tag == 518 + index {
                view.removeFromSuperview()
            }
        }
    }
}
