//
//  ArrayExtension.swift
//  Parttime
//
//  Created by 李俊賢 on 2018/4/18.
//  Copyright © 2018年 Addcn. All rights reserved.
//

import Foundation

public extension Array {
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
    
    func convertObjectToDict() -> [Dictionary<String, Any>] {
        var tmpAry = [[String: Any]]()
        self.forEach { object in
            if let object = object as? Convertable {
                tmpAry.append(object.convertToDict() ?? [:])
            }
        }
        return tmpAry
    }
}
