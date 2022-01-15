//
//  DetailVCExtension.swift
//  RichMan
//
//  Created by JUMP on 2022/1/13.
//

import UIKit

// MARK: - CardViewDelegate
extension DetailVC: CardViewDelegate {
    func tapMainTeam(_ imageView: UIImageView) {
        
    }
    
    func tapSubTeam(_ imageView: UIImageView) {
        let teamAry = TeamKey.allCases
        var actions = [UIAlertAction]()
        
        for key in teamAry {
            actions.append(UIAlertAction(title: key.ToName(), style: .default, handler: { action in
                imageView.image = UIImage(named: key.rawValue)
            }))
        }
        
        UIAlertController.show(title: "選擇對戰隊伍", msg: nil,
                               style: .actionSheet, actions: actions,
                               sourceView: imageView)
        
    }
    

    func tapImageView(_ imageView: UIImageView) {
        showImageViewer(imageView)
    }
    
    
}

// MARK: - 動畫相關
extension DetailVC {
    
    func closeMark() {
        // 先放大再縮小
        self.markView.isFront = false
        
        
        let scale = 1.1
        UIView.animate(withDuration: 0.3, delay: 0.3) {
            self.markView.transform = CGAffineTransform(scaleX: scale, y: scale)
        } completion: { bool in
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.markView.transform = .identity
            }
            self.blurView.fadeOut(0.6)
            self.markHeight.constant = 128
            self.markWidth.constant = 630
            self.markView.markWidth.constant = 80
            let newConstraint = self.markCenterY.constraintWithMultiplier(1.8)
            self.view.removeConstraint(self.markCenterY)
            self.view.addConstraint(newConstraint)
            self.markCenterY = newConstraint
            
//            UIView.animate(withDuration: 0.4) {
//
//                self.view.layoutIfNeeded()
//            }
            
            UIView.animate(withDuration: 0.4, delay: 0, options: []) {
                self.view.layoutIfNeeded()
            } completion: { bool in
                self.markView.backImg.image = UIImage(named: "問號圖")
                self.isCanTapCir = true
            }

        }
        
    }
    
    /// 問號動畫
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
    
    // 卡片位移
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
        default:
            break
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        // 翻牌動畫
        transitionTest(i: timeAry.count, targetView: card)
//        transitionTest(i: 1, targetView: card)
        
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
    
    /// 翻牌動畫
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
    
    func closeCard(type: CardType) {
        secTimer.invalidate()
        sec = countDefault
        
        let card: CardView = type == .chance ? chanceCard : fateCard
        
        
        // 翻牌動畫
        
        UIView.transition(with: card, duration: 0.5, options: .transitionFlipFromLeft) {
            card.isFront = false
        } completion: { finish in
            self.blurView.fadeOut(0.6)
            let centerX: NSLayoutConstraint = type == .chance ? self.chanceCenterX : self.fateCenterX
            let width: NSLayoutConstraint = type == .chance ? self.chanceWidth : self.fateWidth
            width.constant = 280
            
            let float: CGFloat = type == .chance ? 0.5 : 1.5
            let newConstraint = centerX.constraintWithMultiplier(float)
            self.view.removeConstraint(centerX)
            self.view.addConstraint(newConstraint)
            
            switch type {
            case .chance:
                self.chanceCenterX = newConstraint
            case .fate:
                self.fateCenterX = newConstraint
            default:
                break
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        
    }
}


