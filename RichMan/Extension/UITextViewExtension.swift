//
//  UITextViewExtension.swift
//  Parttime
//
//  Created by 莊文博 on 2020/12/21.
//  Copyright © 2020 Addcn. All rights reserved.
//
import UIKit
import Foundation

extension UITextView {
    /// 設定文字段落
    func setLineSpaceOfAttribute(point: CGFloat) {
        var param = [NSAttributedString.Key : Any]()
        param[.font] = self.font
        param[.foregroundColor] = self.textColor
        
        // 段落間距
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = point
        param[.paragraphStyle] = paragraph
        
        let attributedString = NSMutableAttributedString(string: self.text ?? "",
                                                         attributes: param)
        self.attributedText = attributedString
    }
}
