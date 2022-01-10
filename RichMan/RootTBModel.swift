//
//  RootTBModel.swift
//  RichMan
//
//  Created by 莊文博 on 2022/1/6.
//

import Foundation
import UIKit

public class RootTBModel: NSObject {
    
    var data = [TeamData]()
    
    func setData() {
        var tmp = TeamData()
        tmp.key = .chick
        tmp.color = .main
        tmp.score = 888
        data.append(tmp)
        
        tmp = TeamData()
        tmp.key = .marry
        tmp.color = .marry
        tmp.score = 888
        data.append(tmp)
        
        tmp = TeamData()
        tmp.key = .bear
        tmp.color = .bear
        tmp.score = 888
        data.append(tmp)
        
        tmp = TeamData()
        tmp.key = .tasker
        tmp.color = .tasker
        tmp.score = 888
        data.append(tmp)
        
        
    }
}

struct TeamData {
    var key = TeamKey.chick
    var color = UIColor.black
    var score = 0
}

enum TeamKey: String {
    case bear
    case chick
    case marry
    case tasker
}
