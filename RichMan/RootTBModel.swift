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
    
//    func setData() {
//        var tmp = TeamData()
//        tmp.key = .chick
//        tmp.score = 888
//        data.append(tmp)
//        
//        tmp = TeamData()
//        tmp.key = .marry
//        tmp.score = 888
//        data.append(tmp)
//        
//        tmp = TeamData()
//        tmp.key = .bear
//        tmp.score = 888
//        data.append(tmp)
//        
//        tmp = TeamData()
//        tmp.key = .tasker
//        tmp.score = 888
//        data.append(tmp)
//        
//        
//    }
}

struct TeamData: Codable {
    var key = TeamKey.chick
    var score = 888
    var numberTimes = 0
    var log = [String]()
}

enum TeamKey: String, Codable, CaseIterable {
    case bear
    case chick
    case marry
    case tasker
    
    func ToName() -> String {
        switch self {
        case .bear:
            return "熊班"
        case .chick:
            return "小雞"
        case .marry:
            return "啾喜"
        case .tasker:
            return "阿姆"
        }
    }
    
    func toColor() -> UIColor {
        switch self {
        case .bear:
            return .bear
        case .chick:
            return .main
        case .marry:
            return .marry
        case .tasker:
            return .tasker
        }
    }
}


