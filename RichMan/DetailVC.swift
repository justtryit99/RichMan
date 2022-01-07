//
//  DetailVC.swift
//  RichMan
//
//  Created by 莊文博 on 2022/1/6.
//

import UIKit

class DetailVC: UIViewController {

    var text = ""
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    
    deinit {
        print("\(String(describing: self)) deinit!!!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = text
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapCardView))
        cardView.addGestureRecognizer(tap)
    }

    @IBAction func clickButton(_ sender: Any) {
        let popupVC: PopVC = MainSB.with(id: .popVC)
        present(popupVC, animated: true, completion: nil)
    }
    
    
    let ary: [TimeInterval] = [0.5, 0.3, 0.2, 0.2, 0.3, 0.5]
    
    func transitionTest(i: Int, time: TimeInterval) {
        
        
//        UIView.transition(with: cardView, duration: 0.2, options: .transitionFlipFromRight) {
//            self.cardView.backgroundColor = .random()
//        } completion: { finish in
//
//            i -= 1
//            if i > 0 {
//                self.transitionTest()
//            }
//
//
//        }
    }
    
    @objc func tapCardView() {
        
        UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromRight) {
            UIView.setAnimationRepeatCount(2)
            self.cardView.backgroundColor = .random()
        } completion: { finish in
            UIView.transition(with: self.cardView, duration: 0.3, options: .transitionFlipFromRight) {
                UIView.setAnimationRepeatCount(3)
                self.cardView.backgroundColor = .random()
            } completion: { finish in
                
            }
        }
        
        
        
        
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
