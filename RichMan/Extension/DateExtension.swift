//
//  DateExtension.swift
//  Parttime
//
//  Created by JUMP on 2018/7/16.
//  Copyright © 2018年 Addcn. All rights reserved.
//

import Foundation

extension Date {
    static func local() -> Date {
        let currentDate = Date()
        let timeZone = NSTimeZone.system
        let timeInterval = timeZone.secondsFromGMT(for: currentDate)
        let localDate = currentDate.addingTimeInterval(TimeInterval(timeInterval))
        return localDate
    }
    
    /// 間隔24小時後的時間
    static func tomorrow() -> Date {
        let localDate = Date.local()
        let nextTime: TimeInterval = 24*60*60
        return localDate.addingTimeInterval(nextTime)
    }
    
    /// 單純就是隔天的日期，ex: 隔天 00:00
    static func tomorrowDate() -> Date {
        let date = Date()
        let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to:  date)
        let tomorrowTmp = Calendar.current.dateComponents([.year,.month,.day], from: tomorrowDate!)
        var tomorrowDateComponents = DateComponents()
        tomorrowDateComponents.year = tomorrowTmp.year
        tomorrowDateComponents.day = tomorrowTmp.day
        tomorrowDateComponents.month = tomorrowTmp.month
        tomorrowDateComponents.timeZone = TimeZone(abbreviation: "GMT")
        let tomorrow = Calendar.current.date(from: tomorrowDateComponents)
        return tomorrow!
    }
    
    /// 單純就是隔幾天的日期，ex: 隔天 00:00
    static func afterDay(_ count: Int) -> Date {
        let date = Date()
        let tomorrowDate = Calendar.current.date(byAdding: .day, value: count, to:  date)
        let tomorrowTmp = Calendar.current.dateComponents([.year,.month,.day], from: tomorrowDate!)
        var tomorrowDateComponents = DateComponents()
        tomorrowDateComponents.year = tomorrowTmp.year
        tomorrowDateComponents.day = tomorrowTmp.day
        tomorrowDateComponents.month = tomorrowTmp.month
        tomorrowDateComponents.timeZone = TimeZone(abbreviation: "GMT")
        let tomorrow = Calendar.current.date(from: tomorrowDateComponents)
        return tomorrow!
    }
    
    // 七天後
    static func afterSeven() -> Date {
        let localDate = Date.local()
        let nextTime: TimeInterval = 24*60*60*7
        return localDate.addingTimeInterval(nextTime)
    }
    
    // 一個月後
    static func afterMonth() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let str = formatter.string(from: Date())
        
        // formatter出現時間是格林威治，要轉成local
        let localDate = formatter.date(from: str)!.toLocal()
        let nextTime: TimeInterval = 24*60*60*30
        return localDate.addingTimeInterval(nextTime)
    }
    
    // 既有date轉換
    func toLocal() -> Date {
        let timeZone = NSTimeZone.system
        let timeInterval = timeZone.secondsFromGMT(for: self)
        let localDate = self.addingTimeInterval(TimeInterval(timeInterval))
        return localDate
    }
    
    // 時間差異
    func secondBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.second], from: self, to: toDate)
        return components.second ?? 0
    }
    
    // 格式化時間
    func formatter(style: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = style
        
        // 因為是用已經local過的時間，timeZone要改成原始zone，出來的時間就不會有差異
        formatter.timeZone = TimeZone(identifier: "UTC")
        
        let str = formatter.string(from: self)
        
        return str
    }
    
    /// 獲取當前毫秒時間戳
    var milliStamp : Double {
        let timeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        
        let double = Double(millisecond)
        
        return double
    }
    
    /// 日期(西元)轉換成民國年字串
    func TWYearFormat(_ style: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = style
        dateFormatter.locale = Locale(identifier: "zh_Hant_TW") // 設定地區(台灣)
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei") // 設定時區(台灣)
        dateFormatter.calendar = Calendar(identifier: .republicOfChina)
        return dateFormatter.string(from: self)
    }
    
}
