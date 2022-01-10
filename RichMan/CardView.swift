//
//  CardView.swift
//  RichMan
//
//  Created by JUMP on 2022/1/8.
//

import UIKit

enum CardType {
    case chance
    case fate
}

class CardView: BaseView {
    
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var frontBaseView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var abcButtonView: UIView!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var textBaseView: UIView!
    @IBOutlet weak var contentImg: UIImageView!
    
    // 直接替換背景圖不會淡出，再用一張圖片處理
    @IBOutlet weak var frontImg: UIImageView!
    
    var type: CardType = .chance {
        didSet {
            let backName = type == .chance ? "機會" : "命運"
            cardImg.image = UIImage(named: backName)
        }
    }
    
    var isFront = false {
        didSet {
            let time = 0.8
            if isFront {
                cardImg.fadeOut(time) {
                    
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
        textBaseView.setCorner(radius: 10)
        contentImg.setCorner(radius: 5)
        buttonA.setMainStyle()
        buttonB.setMainStyle()
        buttonC.setMainStyle()
        
        
        frontImg.isHidden = true
        let backName = type == .chance ? "機會" : "命運"
        let name = isFront ? "正面" : backName
        self.cardImg.image = UIImage(named: name)
        frontBaseView.isHidden = !isFront
        contentLabel.text = "不服判決、延誤比賽、禮貌欠佳、服裝不整、抓住籃圈等以上動作所違反的規則稱之為？ "
    }

}
