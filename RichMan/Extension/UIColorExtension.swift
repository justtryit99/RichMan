//
//  UIColorExtension.swift
//  Parttime
//
//  Created by 許秉翔 on 2017/9/26.
//  Copyright © 2017年 許秉翔. All rights reserved.
//

import UIKit

extension UIColor {
    public class func RGBA(r: CGFloat ,g: CGFloat, b :CGFloat, alpha :CGFloat) -> UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }

    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b :CGFloat, _ alpha :CGFloat) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
}

extension UIColor {
    static let black_a2 = UIColor(0, 0, 0, 0.02)
    static let black_a5 = UIColor(0, 0, 0, 0.05)
    static let black_a70 = UIColor(0, 0, 0, 0.7)
    static let black_a30 = UIColor(0, 0, 0, 0.3)
    static let black_a15 = UIColor(0, 0, 0, 0.15)
    static let black_a50 = UIColor(0, 0, 0, 0.5)
    
    static let orange_a1 = UIColor(235, 120, 30, 1)             // 正橘色
    static let main = UIColor(255, 235, 80, 1)                  // 主色系黃
    static let mainHightLight = UIColor(245, 220, 50, 1)        // 主色系點擊時
    static let mainBorder = UIColor(250, 218, 0, 1)             // 主色系按鍵邊框
    static let mainDisBG = UIColor(255, 245, 191, 1)            // disable主色系按鈕背景
    static let mainDisBD = UIColor(255, 239, 147, 1)            // disable主色系按鈕邊框
    
    static let subBtn = UIColor(250, 250, 250, 1)               // 淺灰色按鍵色
    static let subBtnBorder = UIColor(0, 0, 0, 0.1)             // 淺灰色按鍵邊框
    static let subBtnHightLight = UIColor(0, 0, 0, 0.05)        // 淺灰色系點擊時
    
    static let lightYellow = UIColor(255, 250, 219, 1)          // 鵝黃色，ex.topBar
    static let lakeGreen = UIColor(63, 216, 182, 1)             // 湖水綠，用在信用良好標籤
    static let lightPink = UIColor(239, 123, 123, 1)            // 淺粉，放鳥標籤
    static let lightRed = UIColor(235, 90, 90, 1)              // 淺紅
    static let rgb245 = UIColor(245, 245, 245, 1)
    
    static let r255_g185_b69 = UIColor(255, 185, 69, 1)         // 商品直接換的橘
    static let placeHolder = UIColor(195, 195, 197, 1)          // textField placeholder color
}

public func ToColor (hex:String) -> UIColor {
    // 字串調整
    let cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    // 顏色轉換
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
