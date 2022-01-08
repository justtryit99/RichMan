//
//  CardView.swift
//  RichMan
//
//  Created by JUMP on 2022/1/8.
//

import UIKit

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
    
    
    var isFront = false {
        didSet {
            frontBaseView.isHidden = !isFront
            let name = isFront ? "正面" : "命運"
            cardImg.image = UIImage(named: name)
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
        buttonA.setMainStyle()
        buttonB.setMainStyle()
        buttonC.setMainStyle()
        
        frontBaseView.isHidden = true
        
        
        countLabel.text = "簡述旅行業之「居中之結構地位」的特性為何簡述旅行業之「居中之結構地位」的特性為何"
    }

}
