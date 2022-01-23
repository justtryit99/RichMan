//
//  DetailVC.swift
//  RichMan
//
//  Created by 莊文博 on 2022/1/6.
//

import UIKit

protocol DetailVCDelegate: AnyObject {
    func detatilSendReload()
}

class DetailVC: UIViewController {
    
    weak var delegate: DetailVCDelegate?
    
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
    
    var teamKey = TeamKey.chick
    var teamData: TeamData {
        return share.dataAry[getTeamRow(key: teamKey)]
    }
    
    
    var sec = 10
    let countDefault = 11
    var secTimer = Timer()
    var tapCardType = CardType.chance
    var isCountScore = false
    
    
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
        markView.delegate = self
        
        
        label.text = "\(sec)"
        label.isHidden = true
        
        teamImageView.image = UIImage(named: teamKey.rawValue)
        teamImageView2.image = UIImage(named: teamKey.rawValue)
        
        numberTimes.setTextBorder(color: .black, textColor: .silvery68, width: -2)
        numberTimes.text = "x\(teamData.numberTimes)"
        
        setTap()
    }
    
    func setTap() {
        let tapCh = UITapGestureRecognizer(target: self, action: #selector(tapChanceCard))
        chanceCard.addGestureRecognizer(tapCh)
        let tapFa = UITapGestureRecognizer(target: self, action: #selector(tapFateCard))
        fateCard.addGestureRecognizer(tapFa)
        let tapMa = UITapGestureRecognizer(target: self, action: #selector(tapMark))
        markView.addGestureRecognizer(tapMa)
        let tapTeam1 = UITapGestureRecognizer(target: self, action: #selector(tapTeam1))
        teamImageView.addGestureRecognizer(tapTeam1)
        let tapTeam2 = UITapGestureRecognizer(target: self, action: #selector(tapTeam2))
        teamImageView2.addGestureRecognizer(tapTeam2)
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
    
    // MARK: 點擊隊伍頭像 (起點、監獄)
    @objc func tapTeam1() {
        let row = getTeamRow(key: self.teamKey)
        
        let overStart = UIAlertAction(title: "通過起點", style: .default) { action in
            
            let score = 200
            
            showAlert(title: "\(self.teamKey.ToName()) 通過起點\n增加 \(score) 積分") { action in
                
                logEvent(row: row, score: score ,msg: "通過起點")
                
                share.dataAry[row].score += score
                self.delegate?.detatilSendReload()
            }
            
        }
        
        let prison = UIAlertAction(title: "進入監獄", style: .destructive) { action in
            showAlert(title: "\(self.teamKey.ToName()) 進入監獄\n減少遊玩一次") { action in
                self.addNumberTimes()
                self.addNumberTimes()
                logEvent(row: row, score: 0, msg: "進入監獄，減少遊玩一次")
                saveToDefaults()
            }
        }
        
        let inStart = UIAlertAction(title: "剛好到起點", style: .default) { action in
            showAlert(title: "\(self.teamKey.ToName()) 剛好到起點") { action in
                self.addNumberTimes()
                logEvent(row: row, score: 0 ,msg: "剛好到起點")
                saveToDefaults()
            }
            
        }
        
        UIAlertController.show(title: "選擇事件", style: .actionSheet,
                               actions: [overStart, prison, inStart],
                               sourceView: teamImageView)
        
    }
    
    @objc func tapTeam2() {
        if isCountScore == false {
            showAlert(title: "尚未計分，流局？") { action in
                logEvent(row: getTeamRow(key: self.teamKey), score: 0, msg: "流局")
                saveToDefaults()
                switch self.tapCardType {
                case .chance, .fate:
                    self.closeCard(type: self.tapCardType)
                case .mark:
                    self.closeMark()
                }
            }
        } else {
            switch tapCardType {
            case .chance, .fate:
                closeCard(type: tapCardType)
            case .mark:
                closeMark()
            }
        }
    }
    
    // MARK: 點擊問號
    @objc func tapMark() {
        guard isCanTapCir else {return}
        isCanTapCir = false
        tapCardType = .mark
        addEffect()
        blurView.fadeIn(0.6)
        popMark(i: 2)
        addNumberTimes()
        
        markView.setMarkData(share.getFunnyData())
        isCountScore = false
        saveToDefaults()
    }
    
    // MARK: 點擊機會
    @objc func tapChanceCard() {
        // 要加翻牌後無法再觸發
        chanceCard.teamKey = teamKey
        
        addEffect()
        tapCardType = .chance
        popCard(type: tapCardType)
        addNumberTimes()
        
        chanceCard.setChanceData(share.getChanceData())
        isCountScore = false
        saveToDefaults()
        
    }
    
    // MARK: 點擊命運
    @objc func tapFateCard() {
        // 要加翻牌後無法再觸發
        fateCard.teamKey = teamKey
        
        addEffect()
        tapCardType = .fate
        popCard(type: tapCardType)
        addNumberTimes()
        
        fateCard.setFateData(share.getFateData())
        isCountScore = false
        saveToDefaults()
    }
    
    
    
    @objc func timeCount() {
        sec -= 1
        //print("waitSec: \(sec)")
        
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
    
    func addNumberTimes() {
        let row = getTeamRow(key: self.teamKey)
        share.dataAry[row].numberTimes += 1
        self.numberTimes.text = "x\(share.dataAry[row].numberTimes)"
    }
    
    
    // MARK: - Test Code
    @IBAction func clickButton(_ sender: Any) {
        let popupVC: PopVC = MainSB.with(id: .popVC)
        present(popupVC, animated: true, completion: nil)
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
