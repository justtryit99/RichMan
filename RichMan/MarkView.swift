//
//  MarkView.swift
//  RichMan
//
//  Created by JUMP on 2022/1/8.
//

import UIKit

protocol MarkViewDelegate: AnyObject {
    func clickButtonA(view: MarkView, data: SourceData.Funny)
}

class MarkView: BaseView {
    
    weak var delegate: MarkViewDelegate?
    
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
    
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreTitle: UILabel!
    
    var funnyData = SourceData.Funny()
    
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
                markImg.fadeIn()
                backImg.fadeIn()
                frontBaseView.fadeOut()
                frontImg.fadeOut()
            }
            
        }
    }
    
    // MARK: - Func
    func setMarkData(_ data: SourceData.Funny) {
        self.funnyData = data
        contentLabel.text = data.description
        scoreLabel.text = "\(data.score)"
        
    }
    
    @IBAction func clickButtonA(_ sender: UIButton) {
        delegate?.clickButtonA(view: self, data: self.funnyData)
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
        contentLabel.text = "上班途中搭丟賽，花費積分去買鞋上班途中搭丟賽，花費積分去買鞋上班途中搭丟賽，花費積分去買鞋"
        

        let red = UIImage(named: "red")!
        titleLabel.textColor = UIColor(patternImage: red)
        
        scoreTitle.setBGColor(.gold)
        scoreLabel.setBGColor(.gold)
        actionLabel.setBGColor(.gold)
        
        let strokeTextAttributes = [
          NSAttributedString.Key.strokeColor : UIColor.black,
          NSAttributedString.Key.foregroundColor : UIColor(patternImage: red),
          NSAttributedString.Key.strokeWidth : -2,
          NSAttributedString.Key.font : titleLabel.font]
          as [NSAttributedString.Key : Any]
        
        titleLabel.attributedText = NSMutableAttributedString(string: titleLabel.text!, attributes: strokeTextAttributes)
    }

}
