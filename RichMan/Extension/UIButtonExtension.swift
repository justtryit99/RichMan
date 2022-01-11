//
//  UIButtonExtension.swift
//  layout
//
//  Created by hsiang on 2017/9/23.
//  Copyright © 2017年 許秉翔. All rights reserved.
//

import UIKit

extension UIButton {
    
    //按鈕背景色
    func setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    //有效的按鈕
    func setEnabledButton() {
        //self.titleLabel?.textColor = ToColor(hex: "ffffff")
        self.setTitleColor(APP_MAIN_TEXT_COLOR, for: .normal)
        self.setBackgroundColor(APP_BUTTON_COLOR, forState: .normal)
        self.setBackgroundColor(APP_BUTTON_CLICK_COLOR, forState: .highlighted)
        //self.backgroundColor = APP_BUTTON_COLOR
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = APP_BUTTON_BORDER_COLOR.cgColor
        self.layer.masksToBounds = true
    }
    
    //無效的按鈕
    func setDisabledButton() {
        self.setTitleColor(ToColor(hex: "d2d2d2"), for: .normal)
        self.setBackgroundColor(APP_BUTTON_COLOR, forState: .normal)
        self.setBackgroundColor(APP_BUTTON_COLOR, forState: .highlighted)
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = APP_BUTTON_BORDER_COLOR.cgColor
        self.layer.masksToBounds = true
    }
    
    //主色系按鈕
    func setMainButton() {
        self.isEnabled = true
        self.setTitleColor(COLOR_OF_MAIN_BUTTON_TEXT, for: .normal)
        self.setTitleColor(COLOR_OF_MAIN_BUTTON_TEXT, for: .highlighted)
        self.setBackgroundColor(COLOR_OF_MAIN_BUTTON, forState: .normal)
        self.setBackgroundColor(COLOR_OF_MAIN_BUTTON_HIGHLIGHTED, forState: .highlighted)
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = COLOR_OF_MAIN_BUTTON_BORDER.cgColor
        self.layer.masksToBounds = true
    }
    
    //主色系按鈕無效
    func setMainButtonDisabled() {
        self.isEnabled = false
        self.setTitleColor(COLOR_OF_MAIN_BUTTON_TEXT_DISABLED, for: .disabled)
        self.setTitleColor(COLOR_OF_MAIN_BUTTON_TEXT_DISABLED, for: .highlighted)
//        self.setBackgroundColor(COLOR_OF_MAIN_BUTTON_DISABLED, forState: .normal)
//        self.setBackgroundColor(COLOR_OF_MAIN_BUTTON_DISABLED, forState: .highlighted)
        self.setBackgroundColor(COLOR_OF_MAIN_BUTTON_DISABLED, forState: .disabled)
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = COLOR_OF_MAIN_BUTTON_BORDER.cgColor
        self.layer.masksToBounds = true
    }
    
    // 設置圓角按鈕
    func setCorner(_ radius:CGFloat = 5, borderWidth:CGFloat = 1, BGColor:UIColor, BDColor:UIColor) {
        
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.backgroundColor = BGColor.cgColor
        self.layer.borderColor = BDColor.cgColor
    }
    
    /// 設定主色系按鈕 Jump
    func setMainStyle() {
        
//        self.setTitleColor(.black, for: .normal)
//        self.setBackgroundColor(.bear, forState: .normal)
//
//        self.setTitleColor(.black, for: .highlighted)
//        self.setBackgroundColor(Color.mainHightLight, forState: .highlighted)
//
//        self.setTitleColor(Color.black_a10, for: .disabled)
//        self.setBackgroundColor(Color.mainDisBG, forState: .disabled)
//        self.layer.masksToBounds = true
//
////        self.setCorner(BGColor: Color.main,
////                       BDColor: Color.mainBorder)
//
//        self.setCorner(radius: 5)
        
        
        self.setTitleColor(.black, for: .normal)
        
        
    }
    
    /// 設定 isEnabled狀態、boderColor old
    func set(isEnabled: Bool,
             enabledBDColor: UIColor = Color.mainBorder,
             disabledBDColor: UIColor = Color.mainDisBD) {
        
        self.isEnabled = isEnabled
        self.layer.borderColor = isEnabled ? enabledBDColor.cgColor : disabledBDColor.cgColor
    }
    
    /// 設定 isEnabled狀態、boderColor, 新的 2020.08.21
    func setEnabled(_ isEnabled: Bool, BDColor: UIColor) {
        self.isEnabled = isEnabled
        self.layer.borderColor = BDColor.cgColor
    }
    
    /// 設定灰色系按鈕
    func setSubStyle() {
        self.setTitleColor(.black, for: .normal)
        self.setBackgroundColor(Color.subBtn, forState: .normal)
        
        self.setTitleColor(.black, for: .highlighted)
        self.setBackgroundColor(Color.subBtnHightLight, forState: .highlighted)
        
        self.setTitleColor(Color.black_a10, for: .disabled)
        self.setBackgroundColor(Color.black_a10, forState: .disabled)
        self.setBackgroundImage(nil, for: .disabled) // 因在TwoButtonBar有設圖片
        self.layer.masksToBounds = true
        
        if self.isEnabled {
            self.setCorner(BGColor: Color.subBtn,
                           BDColor: Color.subBtnBorder)
        } else {
            self.setCorner(BGColor: Color.subBtn,
                           BDColor: Color.subBtnHightLight)
        }
    }
    
    /// 設定按鈕背景、title顏色
    func setStatusColor() {
        self.setTitleColor(COLOR_OF_MAIN_BUTTON_TEXT, for: .normal)
        self.setTitleColor(COLOR_OF_MAIN_BUTTON_TEXT, for: .highlighted)
        self.setBackgroundColor(COLOR_OF_MAIN_BUTTON, forState: .normal)
        self.setBackgroundColor(COLOR_OF_MAIN_BUTTON_HIGHLIGHTED, forState: .highlighted)
    }
    
    func setEnableColor(title:UIColor, background:UIColor) {
        self.setTitleColor(title, for: .normal)
        self.setBackgroundColor(background, forState: .normal)
    }
    
    func setHeightlightColor(title:UIColor, background:UIColor) {
        self.setTitleColor(title, for: .highlighted)
        self.setBackgroundColor(background, forState: .highlighted)
    }
    
    func setDisableColor(title:UIColor, background:UIColor) {
        self.setTitleColor(title, for: .disabled)
        self.setBackgroundColor(background, forState: .disabled)
    }

}
