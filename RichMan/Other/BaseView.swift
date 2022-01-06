//
//  BaseView.swift
//  Parttime
//
//  Created by JUMP on 2018/8/9.
//  Copyright © 2018年 Addcn. All rights reserved.
//

import UIKit

class BaseView: UIView {

    var isEnable = false
    
    @IBOutlet var contentView: UIView!
    
    //初始化時將xib中的view添加進來
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addConstraints()
    }
    
    //初始化時將xib中的view添加進來
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addConstraints()
    }
    
    //載入xib
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    //設置好xib視圖約束
    func addConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        var constraint = NSLayoutConstraint(item: contentView!, attribute: .leading,relatedBy: .equal, toItem: self, attribute: .leading,multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView!, attribute: .trailing,relatedBy: .equal, toItem: self, attribute: .trailing,multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView!, attribute: .top, relatedBy: .equal,toItem: self, attribute: .top, multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView!, attribute: .bottom,relatedBy: .equal, toItem: self, attribute: .bottom,multiplier: 1, constant: 0)
        addConstraint(constraint)
    }
    
    // 顯示
    func showPop() {
        setStatusBarBackground(color: .clear)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        })
    }
    
    // 消失
    func hidePop() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
//
//    func commonInit() {
//        let className = type(of: self)
//        let name = NSStringFromClass(className).components(separatedBy: ".").last
//        Bundle.main.loadNibNamed(name!, owner: self, options: nil)
//        addSubview(contentView)
//
//        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }
    

}
