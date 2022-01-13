//
//  DetailVCExtension.swift
//  RichMan
//
//  Created by JUMP on 2022/1/13.
//

import UIKit

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
                               sourceView: imageView, isMid: false)
        
    }
    

    func tapImageView(_ imageView: UIImageView) {
        showImageViewer(imageView)
    }
    
    
}
