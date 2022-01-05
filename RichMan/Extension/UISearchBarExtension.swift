//
//  UISearchBarExtension.swift
//  Parttime
//
//  Created by JUMP on 2018/10/30.
//  Copyright © 2018 Addcn. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    var textField: UITextField {
        
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            if let textField = self.value(forKey: "searchField") as? UITextField {
                return textField
            } else {
                return UITextField()
            }
        }
    }
    
    var cancelBtn: UIButton {
        if let button = self.value(forKey: "cancelButton") as? UIButton {
            return button
        } else {
            return UIButton()
        }
    }
}
