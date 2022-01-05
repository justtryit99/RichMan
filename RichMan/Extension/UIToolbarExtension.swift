//
//  UIToolbarExtension.swift
//  Parttime
//
//  Created by JUMP on 2021/7/14.
//  Copyright © 2021 Addcn. All rights reserved.
//
import UIKit
import Foundation

extension UIToolbar {
    func create(target: UIViewController, action: Selector) {
        self.frame = CGRect(x: 0, y: 0, width: WIDTH, height: 40)
        let doneItem = UIBarButtonItem()
        doneItem.image = UIImage(named: "icon-Confirmation-theme-28x28")
        doneItem.tintColor = .black
        doneItem.style = .plain
        doneItem.target = target
        doneItem.action = action
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: self, action: nil)
        self.items = [flexibleSpace, flexibleSpace, flexibleSpace, flexibleSpace, flexibleSpace, doneItem]
        self.backgroundColor = .white
        self.barTintColor = .white
    }
}
