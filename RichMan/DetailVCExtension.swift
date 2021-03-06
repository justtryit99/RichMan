//
//  DetailVCExtension.swift
//  RichMan
//
//  Created by JUMP on 2022/1/13.
//

import UIKit

// MARK: - CardViewDelegate
extension DetailVC: CardViewDelegate {
    func clickTimeLabel(data: SourceData.Chance) {
        showAlert(title: "是否超出時間？") { action in
            let text = "超出時間！\n答案是：\(data.answer)\n減少 \(data.score) 積分"
            
            showAlert(title: text) { action in
                let row = getTeamRow(key: self.teamKey)
                logEvent(row: row, score: -data.score,
                         msg: "機會第\(data.number)題 超時")
                share.dataAry[row].score += -data.score
                self.delegate?.detatilSendReload()
                self.isCountScore = true
            }
        }
    }
    
    func clickTwoButton(isSuccess: Bool, data: SourceData.Fate) {
        let successStr = "確定通過命運考驗？\n增加 \(data.score) 積分"
        let failStr = "命運坎坷失敗了？\n減少 \(data.score) 積分"
        let title = isSuccess ? successStr : failStr
        showAlert(title: title) { action in
            let row = getTeamRow(key: self.teamKey)
            logEvent(row: row, score: isSuccess ? data.score : -data.score,
                     msg: "\(isSuccess ? "通過" : "失敗")命運第\(data.number)題")
            share.dataAry[row].score += isSuccess ? data.score : -data.score
            self.delegate?.detatilSendReload()
            self.isCountScore = true
        }
    }
    
    func clickABCbutton(isSuccess: Bool, title: String, data: SourceData.Chance) {
        showAlert(title: "選擇答案\n\(title)") { action in
            // 跳答對/答錯
            let successStr = "恭喜答對！\n增加 \(data.score) 積分"
            let failStr = "答錯啦..\n答案是：\(data.answer)\n減少 \(data.score) 積分"
            let text = isSuccess ? successStr : failStr
            
            showAlert(title: text) { action in
                let row = getTeamRow(key: self.teamKey)
                logEvent(row: row, score: isSuccess ? data.score : -data.score,
                         msg: "\(isSuccess ? "答對" : "答錯")機會第\(data.number)題")
                share.dataAry[row].score += isSuccess ? data.score : -data.score
                self.delegate?.detatilSendReload()
                self.isCountScore = true
            }
            
        }
    }
    
    func tapMainTeam(cardView: CardView) {
        // 主隊？客隊
        let score = cardView.fateData.score
        let number = cardView.fateData.number
        let main = cardView.teamKey.ToName()
        let sub = cardView.subTeamKey.ToName()
        let row = getTeamRow(key: cardView.teamKey)
        let subRow = getTeamRow(key: cardView.subTeamKey)
        
        let mainAction = UIAlertAction(title: "主：\(main)", style: .destructive) { action in
            let text = "\(main)獲得 \(score) 積分\n\(sub)減少 \(score)積分\n執行？"
            showAlert(title: text) { action in
                
                logEvent(row: row, score: score,
                         msg: "與\(sub)對戰命運\(number)勝利")
                logEvent(row: subRow, score: -score,
                         msg: "與\(main)對戰命運\(number)慘敗")
                
                share.dataAry[row].score += score
                share.dataAry[subRow].score -= score
                self.delegate?.detatilSendReload()
                self.isCountScore = true
            }
        }
        let subAction = UIAlertAction(title: "客：\(sub)", style: .default) { action in
            let text = "\(main)減少 \(score) 積分\n\(sub)獲得 \(score)積分\n執行？"
            showAlert(title: text) { action in
                
                logEvent(row: row, score: -score,
                         msg: "與\(sub)對戰命運\(number)慘敗")
                logEvent(row: subRow, score: score,
                         msg: "與\(main)對戰命運\(number)勝利")
                
                share.dataAry[row].score -= score
                share.dataAry[subRow].score += score
                self.delegate?.detatilSendReload()
                self.isCountScore = true
                
            }
        }
        UIAlertController.show(title: "勝利方是？", style: .actionSheet,
                               actions: [mainAction, subAction],
                               sourceView: cardView.mainTeamImg)
    }
    
    func tapSubTeam(cardView: CardView) {
        let teamAry = TeamKey.allCases
        var actions = [UIAlertAction]()
        
        for key in teamAry {
            actions.append(UIAlertAction(title: key.ToName(), style: .default, handler: { action in
                cardView.subTeamKey = key
            }))
        }
        
        UIAlertController.show(title: "選擇對戰隊伍", msg: nil,
                               style: .actionSheet, actions: actions,
                               sourceView: cardView.subTeamImg)
        
    }
    

    func tapImageView(_ imageView: UIImageView) {
        showImageViewer(imageView)
    }
    
    
}

// MARK: - MarkViewDelegate
extension DetailVC: MarkViewDelegate {
    func clickButtonA(view: MarkView, data: SourceData.Funny) {
        let text = data.score > 0 ? "增加" : "減少"
        
        showAlert(title: "\(teamKey.ToName()) \(text) \(abs(data.score)) 積分") { action in
            let row = getTeamRow(key: self.teamKey)
            
            // 問號的分數已含正負符號
            logEvent(row: row, score: data.score,
                     msg: "問號第\(data.number)題")
            share.dataAry[row].score += data.score
            self.delegate?.detatilSendReload()
            self.isCountScore = true
        }
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
//                self.isCanTapCir = true
                isGaming = false
            }

        }
        
    }
    
    /// 問號動畫
    func popMark(i: Int) {
        guard markView.isFront == false else {return}
        
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
            } completion: { bool in
                isGaming = false
            }
            
        }
        
    }
}


