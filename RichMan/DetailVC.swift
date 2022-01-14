//
//  DetailVC.swift
//  RichMan
//
//  Created by 莊文博 on 2022/1/6.
//

import UIKit

class DetailVC: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cardView: UIImageView!
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamImageView2: UIImageView!
    
    @IBOutlet weak var fateCard: CardView!
    @IBOutlet weak var fateWidth: NSLayoutConstraint!
    @IBOutlet weak var fateCenterX: NSLayoutConstraint!
    @IBOutlet weak var chanceCard: CardView!
    @IBOutlet weak var chanceWidth: NSLayoutConstraint!
    @IBOutlet weak var chanceCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var effectView: UIImageView!
    
    @IBOutlet weak var markView: MarkView!
    @IBOutlet weak var markWidth: NSLayoutConstraint!
    @IBOutlet weak var markHeight: NSLayoutConstraint!
    @IBOutlet weak var markCenterY: NSLayoutConstraint!
    
    @IBOutlet weak var numberTimes: UILabel!
    
    
    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    
//    var text = ""
    
    var teamKey = TeamKey.chick
    
    var sec = 10
    let countDefault = 11
    var secTimer = Timer()
    var tapCardType = CardType.chance
    
    
//    var timeAry: [TimeInterval] = [0.5, 0.3, 0.2, 0.2, 0.3, 0.5]
    lazy var timeAry: [TimeInterval] = {
        var ary = [TimeInterval]()
        var i: TimeInterval = 0.1
        for _ in 1...5 {
            ary.append(i)
            i += 0.1
        }
        return ary.reversed()
    }()
    
    
    
    deinit {
        print("\(String(describing: self)) deinit!!!")
    }
    
    // MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        chanceCard.type = .chance
        fateCard.type = .fate
        chanceCard.backgroundColor = .clear
        fateCard.backgroundColor = .clear
        markView.backgroundColor = .clear
        blurView.isHidden = true
        
        chanceCard.delegate = self
        fateCard.delegate = self
        
        
        label.text = "\(sec)"
        label.isHidden = true
        
        teamImageView.image = UIImage(named: teamKey.rawValue)
        teamImageView2.image = UIImage(named: teamKey.rawValue)
        
//        numberTimes.setBGColor(.gold)
        numberTimes.setTextBorder(color: .black, textColor: .gold68, width: -2)
        
        let tapCh = UITapGestureRecognizer(target: self, action: #selector(tapChanceCard))
        chanceCard.addGestureRecognizer(tapCh)
        let tapFa = UITapGestureRecognizer(target: self, action: #selector(tapFateCard))
        fateCard.addGestureRecognizer(tapFa)
        let tapMa = UITapGestureRecognizer(target: self, action: #selector(tapMark))
        markView.addGestureRecognizer(tapMa)
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        secTimer.invalidate()
//    }
    
    @IBAction func radiusChanged(_ sender: UISlider) {
        print("radius: \(sender.value)")
        // 鈔票
        let inputImage =  CIImage(image: UIImage(named: "鈔票")!)
        //使用高斯模糊濾鏡
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setValue(inputImage, forKey:kCIInputImageKey)
        //設置模糊半徑值（越大越模糊）
        filter.setValue(sender.value, forKey: kCIInputRadiusKey)
        let outputCIImage = filter.outputImage!
        let rect = CGRect(origin: CGPoint.zero, size: UIImage(named: "鈔票")!.size)
        let cgImage = context.createCGImage(outputCIImage, from: rect)
        //顯示生成的模糊圖片
//        moneyImg.image = UIImage(cgImage: cgImage!)
    }
    
    @IBAction func alphaChanged(_ sender: UISlider) {
        print("alpha: \(sender.value)")
//        moneyImg.alpha = CGFloat(sender.value)
    }
    
    
    
    func addEffect() {
        // 模糊效果，要刪除subview
        let effect = UIVisualEffectView(frame: UIScreen.main.bounds)
        effect.effect = UIBlurEffect(style: .dark)
        effect.tag = 5
        for view in blurView.subviews {
            if view.tag == 5 {
                view.removeFromSuperview()
            }
        }
        blurView.addSubview(effect)
        blurView.sendSubviewToBack(effect)
    }
    
    @objc func tapMark() {
        guard isCanTapCir else {return}
        isCanTapCir = false
        
        addEffect()
        blurView.fadeIn(0.6)
        popMark(i: 2)
        
    }
    
    @objc func tapChanceCard() {
        // 要加翻牌後無法再觸發
        chanceCard.teamKey = teamKey
        
        addEffect()
        tapCardType = .chance
        popCard(type: tapCardType)
        
        // test
        chanceCard.contentLabel.text = "不服判決、延誤比賽、禮貌欠佳、服裝不整、抓住籃圈等以上動作所違反的規則稱之為？"
    }
    
    @objc func tapFateCard() {
        // 要加翻牌後無法再觸發
        fateCard.teamKey = teamKey
        
        addEffect()
        tapCardType = .fate
        fateCard.fateType = FateType.allCases.randomElement()!
        popCard(type: tapCardType)
    }
    
    // MARK: - 卡片位移
    func popCard(type: CardType) {
        let card: CardView = type == .chance ? chanceCard : fateCard
        guard card.isFront == false else {return}
        blurView.fadeIn(0.6)
        let centerX: NSLayoutConstraint = type == .chance ? chanceCenterX : fateCenterX
        let width: NSLayoutConstraint = type == .chance ? chanceWidth : fateWidth
        
        view.bringSubviewToFront(blurView)
        view.bringSubviewToFront(card)
        width.constant = 498
        
        let newConstraint = centerX.constraintWithMultiplier(1)
        view.removeConstraint(centerX)
        view.addConstraint(newConstraint)
        
        switch type {
        case .chance:
            chanceCenterX = newConstraint
        case .fate:
            fateCenterX = newConstraint
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        // 翻牌動畫
        transitionTest(i: timeAry.count, targetView: card)
        
        DispatchQueue.main.asyncAfter(deadline: 2) { [self] in
            secTimer.invalidate()
            sec = countDefault
            
            if type == .chance {
                secTimer = Timer.scheduledTimer(timeInterval: 1,
                                                target: self,
                                                selector: (#selector(self.timeCount)),
                                                userInfo: nil,
                                                repeats: true)
            }
            
        }
    }
    
    @objc func timeCount() {
        sec -= 1
        print("waitSec: \(sec)")
        
        let card: CardView = tapCardType == .chance ? chanceCard : fateCard
        
        let text = "\(sec)"
        card.countLabel.text = text
        
        //倒數計時結束
        if self.sec <= 0 {
            card.countLabel.text = "Time's up!"
            secTimer.invalidate()
            return
        }
        
        let scale = 2.0
        UIView.animate(withDuration: 0.98, delay: 0) {
//            self.chanceCard.countLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
//            self.chanceCard.countLabel.alpha = 0.0
            card.countLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
            card.countLabel.alpha = 0.0
            
        } completion: { bool in
//            self.chanceCard.countLabel.transform = .identity
//            self.chanceCard.countLabel.alpha = 1.0
            card.countLabel.transform = .identity
            card.countLabel.alpha = 1.0
        }
    }
    
    
    
    

    @IBAction func clickButton(_ sender: Any) {
        let popupVC: PopVC = MainSB.with(id: .popVC)
        present(popupVC, animated: true, completion: nil)
    }
    
//    @objc func timeCount() {
//        sec -= 1
//        print("waitSec: \(sec)")
//
//        let text = "\(sec)"
//        label.text = text
//
//        let scale = 5.0
//        UIView.animate(withDuration: 0.98, delay: 0) {
//            self.label.transform = CGAffineTransform(scaleX: scale, y: scale)
//            self.label.alpha = 0.0
//        } completion: { bool in
//            self.label.transform = .identity
//            self.label.alpha = 1.0
//        }
//
//        //倒數計時結束
//        if sec == 0 {
//            label.text = "時間到"
//            secTimer.invalidate()
//        }
//    }
    
    // MARK: - 翻牌動畫
    func transitionTest(i: Int, targetView: CardView) {
        UIView.transition(with: targetView, duration: self.timeAry[i-1], options: .transitionFlipFromRight) {
//            let isFront = self.cardView.image == UIImage(named: "Frame 6")
//            let name = isFront ? "Frame 1" : "Frame 6"
//            self.cardView.image = UIImage(named: name)
            
        } completion: { finish in

            if i > 1 {
                self.transitionTest(i: i-1, targetView: targetView)
            } else {
                targetView.isFront = true
            }


        }
    }
    
    // MARK: - 問號動畫
    func popMark(i: Int) {
        let time = 0.18
        let sprScale = 1.5
        
        markHeight.constant = 168
        markWidth.constant = markHeight.constant
        
        view.bringSubviewToFront(blurView)
        view.bringSubviewToFront(markView)
        
        let newConstraint = markCenterY.constraintWithMultiplier(1.1)
        view.removeConstraint(markCenterY)
        view.addConstraint(newConstraint)
        markCenterY = newConstraint
        
        // 位移到中心
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.markView.backImg.image = UIImage(named: "問號正")
            self.view.layoutIfNeeded()
        } completion: { bool in
            
            // 波浪
            let scale = 2.8
            let view = MarkView(frame: self.markView.frame)
            view.alpha = 0.8
            view.backImg.image = UIImage(named: "問號正")
            
            // 心跳放大
            UIView.animate(withDuration: time, delay: 0) {
                self.markView.transform = CGAffineTransform(scaleX: sprScale, y: sprScale)
            } completion: { bool in
                
                // 波浪
//                let scale = 2.8
//                let view = MarkView(frame: self.markView.frame)
//                view.alpha = 0.8
//                view.backImg.image = UIImage(named: "問號正")
                self.view.addSubview(view)
                self.view.bringSubviewToFront(self.circleView)
                
                UIView.animate(withDuration: 1, delay: 0) {
                    view.transform = CGAffineTransform(scaleX: scale, y: scale)
                    view.alpha = 0.0
                    
                } completion: { bool in
                    view.removeFromSuperview()
                }
                // 波浪結束
                
                // 心跳縮小
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10) {
                    self.markView.transform = CGAffineTransform.identity
                } completion: { bool in
                    if i > 1 {
                        DispatchQueue.main.asyncAfter(deadline: 0.4) {
                            self.popMark(i: i-1)
                        }
                    } else {
                        
                        let width: CGFloat = 580
                        self.markWidth.constant = width
                        self.markHeight.constant = width
                        self.markView.markWidth.constant = 260
                        
                        // 最終放大
                        UIView.animate(withDuration: 0.6, delay: 0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: []) {
                            
                            self.view.layoutIfNeeded()
                            
                        } completion: { bool in
                            self.markView.isFront = true
//                            self.isCanTapCir = true
                        }
                    }
                    
                }
            }
            
        }
            
    }
    
    func popTest(i: Int) {
//        let count: Float = 2
        let time = 0.15
        let sprScale = 1.3
        
        UIView.animate(withDuration: time, delay: 0) {
            self.circleView.transform = CGAffineTransform(scaleX: sprScale, y: sprScale)
            
        } completion: { bool in
            
            // 波浪
            let scale = 2.8
            let view = CircleView(frame: self.circleView.frame)
//            view.alpha = 0.9
            view.backgroundColor = .lightRed
            self.view.addSubview(view)
            
            self.view.bringSubviewToFront(self.circleView)
            
            UIView.animate(withDuration: 1, delay: 0) {
                view.transform = CGAffineTransform(scaleX: scale, y: scale)
                view.alpha = 0.0
            } completion: { bool in
                view.removeFromSuperview()
            }
            
            
            UIView.animate(withDuration: time) {
                self.circleView.transform = CGAffineTransform.identity

            } completion: { bool in
                if i > 1 {
                    DispatchQueue.main.asyncAfter(deadline: 0.6) {
                        self.popTest(i: i-1)
                    }
                } else {
                    
                    // 最終放大
                    UIView.animate(withDuration: 0.6, delay: 0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: []) {
                        let s = 2.6
                        self.circleView.transform = CGAffineTransform(scaleX: s, y: s)
                    } completion: { bool in
                        self.isCanTapCir = true
                    }
                }
                
            }
        }
    }
    
    var isCanTapCir = true
    @objc func tapCircleView() {
        
        guard isCanTapCir else {return}
        
        isCanTapCir = false
        popTest(i: 2)
        
        
    }
    
    @objc func tapCardView() {
        let scale = 2.0
        UIView.animate(withDuration: 1.2) {
            self.cardView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
    }

}




extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}
extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
