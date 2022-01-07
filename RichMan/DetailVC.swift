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
    
    
    var text = ""
    var sec = 4
    var secTimer = Timer()
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "\(sec)"
        label.isHidden = true
        
        teamImageView.image = UIImage(named: text)
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapCardView))
        cardView.addGestureRecognizer(tap)
//        cardView.isHidden = true
        
        let tapCir = UITapGestureRecognizer(target: self, action: #selector(tapCircleView))
        circleView.addGestureRecognizer(tapCir)
        circleView.backgroundColor = .black
        circleView.isHidden = true
        
        
//        secTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(timeCount)), userInfo: nil, repeats: true)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        secTimer.invalidate()
//    }

    @IBAction func clickButton(_ sender: Any) {
        let popupVC: PopVC = MainSB.with(id: .popVC)
        present(popupVC, animated: true, completion: nil)
    }
    
    @objc func timeCount() {
        sec -= 1
        print("waitSec: \(sec)")
        
        let text = "\(sec)"
        label.text = text
        
        let scale = 5.0
        UIView.animate(withDuration: 0.98, delay: 0) {
            self.label.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.label.alpha = 0.0
        } completion: { bool in
            self.label.transform = .identity
            self.label.alpha = 1.0
        }
        
        //倒數計時結束
        if sec == 0 {
            label.text = "時間到"
            secTimer.invalidate()
        }
    }
    
    
    func transitionTest(i: Int) {
        
        UIView.transition(with: cardView, duration: self.timeAry[i-1], options: .transitionFlipFromRight) {
//            self.cardView.backgroundColor = .random()
            
//            let isFront = self.cardView.image == UIImage(named: "Frame 6")
//            let name = isFront ? "Frame 1" : "Frame 6"
//            self.cardView.image = UIImage(named: name)
            
            
            
            
        } completion: { finish in

            if i > 1 {
                self.transitionTest(i: i-1)
            }


        }
    }
    
    func popTest(i: Int) {
        let count: Float = 2
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
        
        let count: Float = 2
        let time = 0.1
        let sprScale = 1.2
//        UIView.animate(withDuration: time, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: []) {
//
//            UIView.setAnimationRepeatCount(count)
//            self.circleView.transform = CGAffineTransform(scaleX: sprScale, y: sprScale)
//            self.circleView.transform = CGAffineTransform.identity
//        } completion: { bool in
//
//            UIView.animate(withDuration: time, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: []) {
//                let s = 3.0
//                self.circleView.transform = CGAffineTransform(scaleX: s, y: s)
//            } completion: { bool in
//
//            }
//
//        }
        isCanTapCir = false
        popTest(i: 2)
        
        
        
//        UIView.animate(withDuration: time) {
////            UIView.setAnimationRepeatCount(count)
//            self.circleView.transform = CGAffineTransform(scaleX: sprScale, y: sprScale)
//
//
//
//        } completion: { bool in
//            UIView.animate(withDuration: time) {
////                UIView.setAnimationRepeatCount(count)
//                self.circleView.transform = CGAffineTransform.identity
//
//            } completion: { bool in
//
//            }
//        }
        

        
//
//        UIView.animate(withDuration: 0.8,
//                       delay: 0,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 10,
//                       options: [],
//                       animations: {
//            print("0.6")
//            UIView.setAnimationRepeatCount(2)
//            self.circleView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
//        })
//
//
//        UIView.animate(withDuration: 0.8,
//                       delay: 0,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 10,
//                       options: [],
//                       animations: {
//            print("identity")
//            UIView.setAnimationRepeatCount(2)
//                        self.circleView.transform = CGAffineTransform.identity
//                       })
//
//        let scale = 2.8
//        let view = CircleView(frame: circleView.frame)
//        view.backgroundColor = .orange
//        self.view.addSubview(view)
//
//        UIView.animate(withDuration: time) {
//            UIView.setAnimationRepeatCount(count)
//            view.transform = CGAffineTransform(scaleX: scale, y: scale)
//
//            view.alpha = 0.0
//        } completion: { bool in
//            view.removeFromSuperview()
//        }
        

        
    }
    
    @objc func tapCardView() {
        
        let scale = 2.0
        UIView.animate(withDuration: 1.2) {
            self.cardView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        
        
        transitionTest(i: timeAry.count)
        
        
        
        
//        UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromRight) {
//            UIView.setAnimationRepeatCount(2)
//            self.cardView.backgroundColor = .random()
//        } completion: { finish in
//            UIView.transition(with: self.cardView, duration: 0.3, options: .transitionFlipFromRight) {
//                UIView.setAnimationRepeatCount(3)
//                self.cardView.backgroundColor = .random()
//            } completion: { finish in
//
//            }
//        }
        
        
        
        
//        UIView.transition(with: cardView, duration: 0.2, options: .transitionFlipFromRight) {
////                self.cardView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//
////            UIView.setAnimationRepeatCount(10)
//            self.cardView.backgroundColor = .random()
//        } completion: { finish in
////                UIView.animate(withDuration: 0.4, animations: {
////                    self.cardView.transform = CGAffineTransform.identity
////                })
//            print("view done")
//        }
//
//
//        let animator = UIViewPropertyAnimator(duration:0.3, curve: .linear) {
//            self.cardView.backgroundColor = .random()
//         }
//         animator.startAnimation()
//
//
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0, options: .transitionFlipFromRight) {
//            self.cardView.backgroundColor = .random()
//        } completion: { position in
//            print("view done")
//        }

        
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.autoreverse, .curveEaseIn, .repeat], animations: {
//            let transform = CATransform3DIdentity
//            let rotate = CATransform3DRotate(transform, 450, 1, 1, 0)
//            self.cardView.layer.transform = rotate
//        })
        

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
