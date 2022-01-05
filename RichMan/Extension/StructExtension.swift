//
//  StructExtension.swift
//  Parttime
//
//  Created by JUMP on 2018/9/14.
//  Copyright © 2018年 Addcn. All rights reserved.
//

import Foundation
import UIKit

// old
struct StringKV {
    var key: String? = ""
    var value: String? = ""
}

/// new 2020.06.19
struct MenuStruct {
    var key = ""
    var value = ""
    var uiType = AddressType.segment
}

// 2020.11.04
struct TextValueStruct: Equatable, Codable, Convertable {
    var text = ""
    var value = ""
    
}

struct TextValueCodable: Codable {
    let text, value: String?
    
    func toStruct() -> TextValueStruct {
        return TextValueStruct(text: text.str, value: value.str)
    }
}

enum AddressType: String {
    /// 指定地點
    case noSegment = "1"
    /// 不拘
    case segment = "2"
}


// Ambiguous reference to member '<'
// array裡是struct要sorted的解法
extension StringKV: Comparable{
    
    static func <(lhs: StringKV, rhs: StringKV) -> Bool {
        if let j = Int(lhs.key!), let i = Int(rhs.key!) {
            return j < i
        }
        return true
    }

    static func ==(lhs: StringKV, rhs: StringKV) -> Bool {
        if let j = Int(lhs.key!), let i = Int(rhs.key!) {
            return j == i
        }
        return true
    }
}







