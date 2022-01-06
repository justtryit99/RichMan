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
        data.append(tmp)
        
        tmp = TeamData()
        tmp.key = .marry
        tmp.color = .marry
        data.append(tmp)
        
        tmp = TeamData()
        tmp.key = .bear
        tmp.color = .bear
        data.append(tmp)
        
        tmp = TeamData()
        tmp.key = .tasker
        tmp.color = .tasker
        data.append(tmp)
        
        
    }
}

struct TeamData {
    var key = TeamKey.chick
    var color = UIColor.black
}

enum TeamKey: String {
    case bear
    case chick
    case marry
    case tasker
}
