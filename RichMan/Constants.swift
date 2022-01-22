///
//  Constants.swift
//  Parttime
//
//  Created by Mars Lee on 2017/11/22.
//  Copyright © 2017年 Addcn. All rights reserved.
//

import UIKit
import AdSupport
import SwiftyUserDefaults


extension DefaultsKeys {
    static let dataSource = DefaultsKey<Data?>("dataSource")
    static let dataAry = DefaultsKey<[Data]?>("dataAry")
}



public let Defaults = UserDefaults.standard
let AppShared = UIApplication.shared
let shareData = ShareData.instance
let share = ShareData.instance
let NotificationDefault = NotificationCenter.default

let KeyWindow = UIApplication.shared.keyWindow
let PopUpSB = UIStoryboard(name: "PopUp", bundle: nil)
let MainSB = UIStoryboard(name: "Main", bundle: nil)
let TaskSB = UIStoryboard(name: "Task", bundle: nil)
let SocialSB = UIStoryboard(name: "Social", bundle: nil)

// MARK: - 螢幕寬度
let WIDTH:CGFloat  = UIScreen.main.bounds.size.width
// MARK: - 螢幕高度
let HEIGHT:CGFloat = UIScreen.main.bounds.size.height
// MARK: - 畫面高度(螢幕高度扣除navigation bar跟status bar的高度)
let VIEW_HEIGHT:CGFloat = UIScreen.main.bounds.size.height-UINavigationController().navigationBar.frame.height-UIApplication.shared.statusBarFrame.height

/// 整個螢幕高扣掉naviBar & statusBar, 自動計算瀏海機型 2020.12.03
var ViewHeight: CGFloat = getViewHeight()

/// naviBar & statusBar 相加的高
let TopBarHeight = UINavigationController().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
/// statusBar Height
let StatusBarHeight = UIApplication.shared.statusBarFrame.height

/// naviBar Height
let NaviBarHeight = UINavigationController().navigationBar.frame.height

let TabBarHeight = UITabBarController().tabBar.height


//var APIURL:String = "http://wwwstage.chickpt.com.tw/api/"
//let WEBURL:String = "http://wwwstage.chickpt.com.tw/"
//// MARK: - APIURL_ERROR
//let APIURL_ERROR:URL = URL(string: "http://wwwstage.chickpt.com.tw/api/check_app")!

var APIURL:String!
var WEBURL:String!
var APPLINK: String!
var SLACKLINK: String!
// MARK: - APIURL_ERROR
var APIURL_ERROR:URL!


// MARK: - VERSION版號
var APP_VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
// MARK: - BUILD版號
var APP_BUILD = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

let USER_FROM:String = "2"
let APP_STORE_ID:String = "993984776"
let APP_AD_ID = ASIdentifierManager.shared().advertisingIdentifier.uuidString

let APP_BUNDLE_ID = Bundle.main.bundleIdentifier!
let SYSTEMS_URL = URL(string: UIApplication.openSettingsURLString + APP_BUNDLE_ID)!

let AppGroupId = "group.parttime.shareData"

// MARK: - FILEPATH
var FILE_PATH: String {
    let manager = FileManager.default
    
    // 6/14 測試是否修正firebase閃退問題 FilterMenuView.getJSON()
//    let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
//    return url.path!
    
    let urlStr = manager.urls(for: .documentDirectory, in: .userDomainMask)[0].path
    return urlStr
}

//推播設定依陣列排序分別為 0=>求職者收到詢問,1=>雇主收到詢問,2=>雇主收到應徵,3=>系統提醒,4=>訂閱通知
//求職者模式只要0、3、4 雇主模式只要1、2、3
/// 預設推播設定 1: on, 2: off
var PUSH_SETTING:[String] = ["2","2","2","2","2"]

// 有些情況是 1: on, 0: off & 1: on, 2: off
let ON  = "1"
let off = "0"
let off2 = "2"

let falseStr = "false"
let trueStr = "true"

let Hirer = "2"
let Worker = "1"

/// 自定義alet title的垂直空間
let CustomAlertSpace = "\n\n\n\n\n\n\n\n\n"

// MARK: - DIRECTORY
//var DIRECTORY = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:FileManager.SearchPathDomainMask.userDomainMask)
// MARK: - JSONPATH
//var JSON_PATH:URL = DIRECTORY[0] as URL



// MARK: - Color ---------------------------------------------------
struct Color {
    static let black_a70 = UIColor(0, 0, 0, 0.7)
    static let black_a30 = UIColor(0, 0, 0, 0.3)
    static let black_a10 = UIColor(0, 0, 0, 0.15)
    static let black_a50 = UIColor(0, 0, 0, 0.5)
    
    static let orange_a1 = UIColor(235, 120, 30, 1)             // 正橘色
    static let main = UIColor(255, 235, 80, 1)                  // 主色系黃
    static let mainHightLight = UIColor(245, 220, 50, 1)        // 主色系點擊時
    static let mainBorder = UIColor(250, 218, 0, 1)             // 主色系按鍵邊框
    static let mainDisBG = UIColor(255, 245, 191, 1)            // disable主色系按鈕背景
    static let mainDisBD = UIColor(255, 239, 147, 1)            // disable主色系按鈕邊框
    
    static let subBtn = UIColor(250, 250, 250, 1)               // 淺灰色按鍵色
    static let subBtnBorder = UIColor(0, 0, 0, 0.1)             // 淺灰色按鍵邊框
    static let subBtnHightLight = UIColor(0, 0, 0, 0.05)        // 淺灰色系點擊時
    
    static let lightYellow = UIColor(255, 250, 219, 1)          // 鵝黃色，ex.topBar
    static let lakeGreen = UIColor(63, 216, 182, 1)             // 湖水綠，用在信用良好標籤
    static let lightPink = UIColor(239, 123, 123, 1)            // 淺粉，放鳥標籤
    static let lightRed = UIColor(235, 90, 90, 1)              // 淺紅
    
    static let r255_g185_b69 = UIColor(255, 185, 69, 1)         // 商品直接換的橘
}


// MARK: - APP主要顏色(#FFEB50) 黃
public let APP_MAIN_COLOR:UIColor = UIColor(red: 255.0/255.0, green: 235.0/255.0, blue: 80.0/255.0, alpha: 1.0)
// MARK: - APP次要顏色(#FFF9DB)
public let APP_SUB_COLOR:UIColor = UIColor(red: 255.0/255.0, green: 249.0/255.0, blue: 216.0/255.0, alpha: 1.0)
// MARK: - APP主要文字顏色
public let APP_MAIN_TEXT_COLOR:UIColor = .black
// MARK: - APP主要文字顏色
let APP_DISABLED_TEXT_COLOR:UIColor = UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1.0)
// MARK: - APP主要文字顏色
let APP_WARNING_TEXT_COLOR:UIColor = Color.lightRed
// MARK: - APP主要按鈕顏色
let APP_MAIN_BUTTON_COLOR:UIColor = UIColor(red: 255.0/255.0, green: 235.0/255.0, blue: 80.0/255.0, alpha: 1.0)
// MARK: - APP主要按鈕邊框顏色
let APP_MAIN_BUTTON_BORDER_COLOR:UIColor = UIColor(red: 245.0/255.0, green: 220.0/255.0, blue: 50.0/255.0, alpha: 1.0)
// MARK: - APP主要按鈕點擊顏色
let APP_MAIN_BUTTON_CLICK_COLOR:UIColor = UIColor(red: 245.0/255.0, green: 220.0/255.0, blue: 50.0/255.0, alpha: 1.0)
// MARK: - APP按鈕顏色
let APP_BUTTON_COLOR:UIColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
// MARK: - APP按鈕邊框顏色
let APP_BUTTON_BORDER_COLOR:UIColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
// MARK: - APP按鈕邊框顏色
let APP_BUTTON_CLICK_COLOR:UIColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
// MARK: - HR底線顏色 舊的 2020.04.21
//let APP_HR_COLOR:UIColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
let APP_HR_COLOR = Color.black_a30


// MARK: - 灰色(230)
public let GRAY_COLOR_230:UIColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
// MARK: - 灰色(74)
public let GRAY_COLOR_74:UIColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1.0)
// MARK: - 橘色(#EB781E)
public let ORANGE_COLOR:UIColor = UIColor(red: 235.0/255.0, green: 120.0/255.0, blue: 30.0/255.0, alpha: 1.0)
// MARK: - 欄位錯誤顏色(#EB5A5A)
public let FIELD_ERROR_COLOR:UIColor = UIColor(red: 235.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1.0)
// MARK: - 欄位底線顏色(#D2D2D2)
public let FIELD_HR_COLOR:UIColor = UIColor(red: 209.0/255.0, green: 209.0/255.0, blue: 209.0/255.0, alpha: 1.0)
// MARK: - tab bar title(#000000)
public let ALPHA_30:UIColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.3)
// MARK: - tab bar title(#000000)
public let ALPHA_70:UIColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.7)
/// APP主要按鈕顏色
public let COLOR_OF_MAIN_BUTTON:UIColor = UIColor(red: 255.0/255.0, green: 235.0/255.0, blue: 80.0/255.0, alpha: 1.0)
/// APP主要按鈕邊框顏色
public let COLOR_OF_MAIN_BUTTON_BORDER:UIColor = UIColor(red: 255/255.0, green: 218.0/255.0, blue: 0.0/255.0, alpha: 1.0)
/// APP主要按鈕顏色
public let COLOR_OF_MAIN_BUTTON_HIGHLIGHTED:UIColor = UIColor(red: 245.0/255.0, green: 220.0/255.0, blue: 50.0/255.0, alpha: 1.0)
/// APP主要按鈕無效顏色
public let COLOR_OF_MAIN_BUTTON_DISABLED:UIColor = UIColor(red: 255.0/255.0, green: 241.0/255.0, blue: 166.0/255.0, alpha: 1.0)
/// APP主要按鈕文字顏色
public let COLOR_OF_MAIN_BUTTON_TEXT:UIColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
/// APP主要按鈕無效文字顏色
public let COLOR_OF_MAIN_BUTTON_TEXT_DISABLED:UIColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.15)


// MARK: - URL
struct Url {
    static let aboutUs = "https://www.chickpt.com.tw/candidate_intro"
    static let userRule = "https://www.chickpt.com.tw/rule"
    static let caseRule = "https://www.chickpt.com.tw/case_rule"
    static let hirerRule = "https://www.chickpt.com.tw/job_rule"
    static let privacy = "https://www.chickpt.com.tw/privacy"
    static let copyright = "https://www.chickpt.com.tw/copyright"
    static let termsOfService = "https://www.chickpt.com.tw/service"
    static let disclaimer = "https://www.chickpt.com.tw/disclaimer"
    static let hideResume = "https://www.chickpt.com.tw/news/detail/54"
}






