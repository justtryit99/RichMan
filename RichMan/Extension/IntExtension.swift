//
//  IntExtension.swift
//  Parttime
//
//  Created by 許秉翔 on 2017/10/5.
//  Copyright © 2017年 許秉翔. All rights reserved.
//

import UIKit

extension Int {
    var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
    
    var stringValue: String {
        return String(self.intValue)
    }
}

extension CGFloat {
    /// 無條件捨去小數第幾位
    func floor(toDecimal decimal: Int) -> CGFloat {
        let numberOfDigits = pow(10.0, CGFloat(decimal))
        return (self * numberOfDigits).rounded(.towardZero) / numberOfDigits
    }
}
