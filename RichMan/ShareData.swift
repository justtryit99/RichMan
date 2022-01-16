//
//  MessageInfo.swift
//  Parttime
//
//  Created by JUMP on 2018/6/27.
//  Copyright © 2018年 Addcn. All rights reserved.
//

import UIKit

class ShareData: NSObject {
    static let instance = ShareData()
    
    var dataAry = [TeamData]()
    var oldDataAry = [TeamData]()
    
    
    func setData() {
        var tmp = TeamData()
        tmp.key = .chick
        tmp.color = .main
        dataAry.append(tmp)
        
        tmp = TeamData()
        tmp.key = .marry
        tmp.color = .marry
        dataAry.append(tmp)
        
        tmp = TeamData()
        tmp.key = .bear
        tmp.color = .bear
        dataAry.append(tmp)
        
        tmp = TeamData()
        tmp.key = .tasker
        tmp.color = .tasker
        dataAry.append(tmp)
        
        oldDataAry = dataAry
    }
    
    
    
}

func getTeamRow(key: TeamKey) -> Int {
    for (i, cellData) in share.dataAry.enumerated() {
        if cellData.key == key {
            return i
        }
    }
    print("** 找不到team row **")
    return 0
}

// MARK: - Enum

