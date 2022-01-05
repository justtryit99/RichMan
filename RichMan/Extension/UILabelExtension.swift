//
//  UILabelExtension.swift
//  Parttime
//
//  Created by 許秉翔 on 2017/9/27.
//  Copyright © 2017年 許秉翔. All rights reserved.
//

import UIKit
//import TTTAttributedLabel

extension UILabel{
    
    /// 設定文字段落
    func setLineSpaceOfAttribute(point: CGFloat) {
        var param = [NSAttributedString.Key : Any]()
        param[.font] = self.font
        
        // 段落間距
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = point
        param[.paragraphStyle] = paragraph
        
        let attributedString = NSMutableAttributedString(string: self.text ?? "",
                                                         attributes: param)
        self.attributedText = attributedString
    }
    

}

func widthForView(text:String, font:UIFont, height:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:CGFloat.greatestFiniteMagnitude, height:height))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    return label.frame.width
}

