//
//  UIViewExtension.swift
//  Parttime
//
//  Created by 許秉翔 on 2017/9/26.
//  Copyright © 2017年 許秉翔. All rights reserved.
//

import UIKit

extension UIView {

    // MARK: - X
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }

    // MARK: - Y
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }

    // MARK: - WIDTH
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }

    // MARK: - HEIGHT
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }

    // MARK: - SIZE
    public var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }

    // MARK: - ORIGIN
    public var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
    public var positionX: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
    public var positionY: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    /// 變成圓形
    func toCircle() {
        self.layer.cornerRadius = self.width/2
        self.layer.masksToBounds = true
    }
    
}

extension UIView {
    //Y軸移動動畫
    func animateY(_ y: CGFloat, seconds: Float, needAlpha: Bool, completion: ((Bool)->Void)?) {
        UIView.animate(withDuration: TimeInterval(seconds), animations: {
            self.frame.origin.y = y
            if needAlpha {
                if self.alpha == 1.0 {
                    self.alpha = 0.0
                } else {
                    self.alpha = 1.0
                }
            }
        }, completion: completion)
    }
    
    //框線
    func viewSetline() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 1
        self.layer.borderColor = ToColor(hex: "d2d2d2").cgColor
    }
    
    /// 設定框線、顏色
    func setBorder(radius:CGFloat = 5, borderWidth:CGFloat = 1, BDColor:UIColor) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = BDColor.cgColor
    }
    
    /// 設定圓角
    func setCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    /// 移除view所有手勢
    func removeAllGesture() {
        for gesture in self.gestureRecognizers ?? [] {
            self.removeGestureRecognizer(gesture)
        }
    }
    
    /// 移除所有subView
    func removeAllSubview() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    /// 移除所有subLayer
    func removeAllSubLayer() {
        layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
    }
    
}

// MARK: - UIView 隱藏/顯示效果
extension UIView {
    
    /// 淡入 UIView
    /// - Parameters:
    ///   - duration: 特效時間
    ///   - action: 特效玩執行閉包
    func fadeIn(_ duration: TimeInterval = 0.3, callback: @escaping () -> Void = {}) {
        self.alpha = 0.0
        self.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        }) { (_) in
            callback()
        }
    }
    
    /// 淡出 UIView
    /// - Parameters:
    ///   - duration: 特效時間
    ///   - action: 特效玩執行閉包
    func fadeOut(_ duration: TimeInterval = 0.3, callback: @escaping () -> Void = {}) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }) { (_) in
            self.isHidden = true
            self.alpha = 1.0
            callback()
        }
    }
    
    
}


// MARK: CustomUIView
class CustomUIView: UIView {
    var isEnable = false
    var isHit    = false    // 是否可穿透
    
    // 可穿透透明view方法
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self, isHit {
            return nil
        } else {
            return hitView
        }
    }
}

// MARK: CircleView
class CircleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.toCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.toCircle()
    }
}

// MARK: UIStoryboard
extension UIStoryboard {

    func with<T: UIViewController>(id: StoryboardID) -> T {
        
        guard let VC = self.instantiateViewController(withIdentifier: id.rawValue) as? T else {
            fatalError("遺失 \(String(describing: T.self)) StoryboardID")
        }
        
        return VC
    }
}

enum StoryboardID: String {
    case remindReplyBKVC            = "RemindReplyBKVC"
    case contactRecordsFilterVC     = "ContactRecordsFilterVC"
    case dressingRoomVC             = "DressingRoomVC"
    
}
