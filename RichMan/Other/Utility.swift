//
//  Utility.swift
//  Parttime
//
//  Created by JUMP on 2018/6/3.
//  Copyright © 2018年 Addcn. All rights reserved.
//

import Foundation
import SafariServices
import StoreKit
//import Firebase
import Photos
//import MessageUI
//import TLPhotoPicker
//import SlackKit
//import Alamofire

class Utility {
    
    // FIXME: 應該有更簡單的寫法
    class func getNowLocalDate() -> Date? {

        let dateNow:Date = Date()
        let nowTmp = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dateNow)
        var nowDateComponents = DateComponents()
        nowDateComponents.year = nowTmp.year
        nowDateComponents.day = nowTmp.day
        nowDateComponents.month = nowTmp.month
        nowDateComponents.hour = nowTmp.hour
        nowDateComponents.minute = nowTmp.minute
        nowDateComponents.second = nowTmp.second
        nowDateComponents.timeZone = TimeZone(abbreviation: "GMT")

        let now = Calendar.current.date(from: nowDateComponents)

        return now
    }
    
    
    
}


// MARK: - public func
public func getAppDelegate() -> UIApplicationDelegate? {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
        return appDelegate
    } else {
        return UIApplication.shared.delegate
    }
}

/// 取得 SafeAreaInsets
public func getSafeAreaInsets() -> UIEdgeInsets {
    if #available(iOS 11.0, *) {
        
        guard let appDelegate = getAppDelegate() else {return .zero}
        guard let window = appDelegate.window else {return .zero}
        guard let win = window else {return .zero}
        return win.safeAreaInsets
        
    } else {
        return .zero
    }
}

/// 取得螢幕高扣掉statusBar、naviBar、safeAreaBottom的高度
func getViewHeight() -> CGFloat {
    var viewHeight =
            UIScreen.main.bounds.size.height -
            UINavigationController().navigationBar.frame.height -
            UIApplication.shared.statusBarFrame.height
    
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom ?? 34
        viewHeight -= bottomPadding
    }
    return viewHeight
}

/// 改變statusBar顏色
func setStatusBarBackground(color: UIColor) {
    
    /* 9/25 xcode11改statusBar會閃退
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
        statusBar.backgroundColor = color
    } */
}

/// set Navigation上下兩條title
func setDoubleTitle(title:String, subtitle:String) -> UIView {
    let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
    
    titleLabel.backgroundColor = .clear
    titleLabel.textColor = .black
    titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
    titleLabel.text = title
    titleLabel.sizeToFit()
    
    let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
    subtitleLabel.backgroundColor = .clear
    subtitleLabel.textColor = .black
    subtitleLabel.font = UIFont.systemFont(ofSize: 11)
    subtitleLabel.text = subtitle
    subtitleLabel.sizeToFit()
    
    let width = max(titleLabel.frame.size.width, subtitleLabel.frame.size.width)
    let titleView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 30))
    titleView.addSubview(titleLabel)
    titleView.addSubview(subtitleLabel)
    
    let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
    
    if widthDiff < 0 {
        let newX = widthDiff / 2
        subtitleLabel.frame.origin.x = abs(newX)
    } else {
        let newX = widthDiff / 2
        titleLabel.frame.origin.x = newX
    }
    
    titleView.clipsToBounds = true
    
    return titleView
}

/// set Navigation上下兩條靠左title
func setDoubleLeftTitle(title:String, subtitle:String) -> UIView {
    let titleLabel = UILabel(frame: CGRect(x: -8, y: -2, width: 0, height: 0))
    
    titleLabel.backgroundColor = .clear
    titleLabel.textColor = .black
    titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
    titleLabel.text = title
    titleLabel.sizeToFit()
    /*
     2021.07.11 試過label加約束在superView，也試過用stackView，還是有跑版問題
     最後寫死計算，170:左item加右邊三顆item寬度
    */
    titleLabel.width = WIDTH - 170
    
    let subtitleLabel = UILabel(frame: CGRect(x: -8, y: 18, width: 0, height: 0))
    subtitleLabel.backgroundColor = .clear
    subtitleLabel.textColor = .black
    subtitleLabel.font = UIFont.systemFont(ofSize: 11)
    subtitleLabel.text = subtitle
    subtitleLabel.sizeToFit()
    subtitleLabel.width = WIDTH - 170
    
    let titleView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 30))
    titleView.addSubview(titleLabel)
    titleView.addSubview(subtitleLabel)
    
    return titleView
}



protocol Convertable: Codable {
    
}

// Convert struct to dictionary
extension Convertable {
    func convertToDict() -> Dictionary<String, Any>? {
        var dict: Dictionary<String, Any>? = nil
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
        } catch {
            print(error)
        }
        
        return dict
    }
}

/// 正則匹配
///
/// - Parameters:
///   - regex: 匹配規則
///   - validateString: 匹配對test象
/// - Returns: 返回結果
func regularExpression (regex: String,validateString: String) -> [String] {
    do {
        let regex: NSRegularExpression = try NSRegularExpression(pattern: regex, options: [])
        let matches = regex.matches(in: validateString, options: [], range: NSMakeRange(0, validateString.count))
        var data: [String] = Array()
        for item in matches {
            let string = (validateString as NSString).substring(with: item.range)
            data.append(string)
        }
        return data
    }
    catch {
        return []
    }
}


struct PostTypeTextData {
    var searchPlaceHolder = ""
    var areaPopHeader = ""
    var typeText = ""
}
