//
//  MarkView.swift
//  RichMan
//
//  Created by JUMP on 2022/1/8.
//

import UIKit

class MarkView: BaseView {
    
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var markImg: UIImageView!
    @IBOutlet weak var markWidth: NSLayoutConstraint!
    @IBOutlet weak var frontBaseView: UIView!
    @IBOutlet weak var abcButtonView: UIView!
    @IBOutlet weak var buttonA: UIButton!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentBaseView: UIView!
    @IBOutlet weak var frontImg: UIImageView!
    
    
    var isFront = false {
        didSet {
            let time = 0.6
            if isFront {
                markImg.fadeOut(time)
                backImg.fadeOut(time) {
                    
                }
                frontImg.fadeIn(0.3) {
                    self.frontBaseView.fadeIn(0.3)
                }
            } else {
                
            }
            
        }
    }
    
    //初始化時將xib中的view添加進來
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //初始化時將xib中的view添加進來
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        backImg.image = UIImage(named: "問號圖")
        
        contentBaseView.setCorner(radius: 10)
        buttonA.setMainStyle()
        
        frontImg.isHidden = true
        frontBaseView.isHidden = true
        contentLabel.text = "不服判決、延誤比賽、禮貌欠佳、服裝不整、抓住籃圈等以上動作所違反的規則稱之為？ "
    }

}
