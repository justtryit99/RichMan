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
    case gold68
}

extension UILabel {
    func setBGColor(_ type: ColorType) {
        let red = UIImage(named: type.rawValue)!
        self.textColor = UIColor(patternImage: red)
    }
    
    func setTextBorder(color: UIColor, textColor: ColorType, width: Int) {
        let img = UIImage(named: textColor.rawValue)!
        
        let strokeTextAttributes = [
          NSAttributedString.Key.strokeColor : color,
          NSAttributedString.Key.foregroundColor : UIColor(patternImage: img),
          NSAttributedString.Key.strokeWidth : width,
          NSAttributedString.Key.font : self.font]
          as [NSAttributedString.Key : Any]
        
        self.attributedText = NSMutableAttributedString(string: self.text!, attributes: strokeTextAttributes)
    }
}
