//
//  UILabelExtension.swift
//  RichMan
//
//  Created by JUMP on 2022/1/12.
//

import UIKit

enum ColorType: String {
    case red
    case gold
}

extension UILabel {
    func setBGColor(_ type: ColorType) {
        let red = UIImage(named: type.rawValue)!
        self.textColor = UIColor(patternImage: red)
    }
    
    
}
