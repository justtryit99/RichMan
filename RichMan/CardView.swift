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
    case mark
}

enum FateType: CaseIterable {
    case twoButton
    case vsView
}

protocol CardViewDelegate: AnyObject {
    func tapImageView(_ imageView: UIImageView)
    func tapMainTeam(_ imageView: UIImageView)
    func tapSubTeam(_ imageView: UIImageView)
}

class CardView: BaseView {
    
    weak var delegate: CardViewDelegate?
    
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
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreTitle: UILabel!
    @IBOutlet weak var twoButtonView: UIView!
    @IBOutlet weak var vsView: UIView!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var mainTeamImg: UIImageView!
    @IBOutlet weak var subTeamImg: UIImageView!
    
    
    
    
    // 直接替換背景圖不會淡出，再用一張圖片處理
    @IBOutlet weak var frontImg: UIImageView!
    
    
    var teamKey = TeamKey.chick {
        didSet {
            mainTeamImg.image = UIImage(named: teamKey.rawValue)
            subTeamImg.image = UIImage(named: teamKey.rawValue)
        }
    }
    
    
    var fateType = FateType.twoButton {
        didSet {
            switch fateType {
            case .twoButton:
                contentImg.isHidden = false
                vsView.isHidden = true
                twoButtonView.isHidden = false
                contentLabel.text = "請依照圖片動作拍照，通過即可得分"
                
            case .vsView:
                contentImg.isHidden = true
                vsView.isHidden = false
                twoButtonView.isHidden = true
                contentLabel.text = "拳法：海帶拳\n請指定任一隊伍對戰\n生死有命，富貴在天"
            }
        }
    }
    
    var type: CardType = .chance {
        didSet {
            let backName = type == .chance ? "機會" : "命運"
            cardImg.image = UIImage(named: backName)
            
            switch type {
            case .chance:
                twoButtonView.isHidden = true
                vsView.isHidden = true
                
            case .fate:
                countLabel.isHidden = true
                abcButtonView.isHidden = true
                
            default:
                break
            }
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
                countLabel.text = "10"
                cardImg.fadeIn()
                frontImg.fadeOut()
                frontBaseView.fadeOut()
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
        
        
        scoreLabel.setBGColor(.gold)
        scoreTitle.setBGColor(.gold)
        vsLabel.setBGColor(.red)
        
        let tapImg = UITapGestureRecognizer(target: self, action: #selector(tapImageView(_:)))
        contentImg.addGestureRecognizer(tapImg)
        let tapMainTeam = UITapGestureRecognizer(target: self, action: #selector(tapMainTeam))
        mainTeamImg.addGestureRecognizer(tapMainTeam)
        let tapSubTeam = UITapGestureRecognizer(target: self, action: #selector(tapSubTeam))
        subTeamImg.addGestureRecognizer(tapSubTeam)
        
        
    }
    
    @objc func tapImageView(_ sender: UITapGestureRecognizer) {
        guard let img = sender.view as? UIImageView else {
            print("tapImageView error")
            return
        }
        delegate?.tapImageView(img)
    }
    
    @objc func tapMainTeam() {
        delegate?.tapMainTeam(mainTeamImg)
    }
    
    @objc func tapSubTeam() {
        delegate?.tapSubTeam(subTeamImg)
    }
    
}
