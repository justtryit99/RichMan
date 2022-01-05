//
//  Enum.swift
//  Parttime
//
//  Created by JUMP on 2018/6/3.
//  Copyright © 2018年 Addcn. All rights reserved.
//

import Foundation


// MARK: - Enum
enum PostApi: String {
    case job_subscribe = "job_subscribe"
}

enum PatchApi: String {
    case job_subscribe = "job_subscribe"
}

enum StoryboardID: String {
    case remindReplyBKVC            = "RemindReplyBKVC"
    case interviewHelpVC            = "InterviewHelpVC"
    case termsUpdateVC              = "TermsUpdateVC"
    case resumeReviewVC             = "ResumeReviewVC"
    case creditExplainVC            = "CreditExplainVC"
    case bookingHelpVC              = "BookingHelpVC"
    case applyVC                    = "ApplyVC"
    case newFeatureVC               = "NewFeatureVC"
    case missionVC                  = "MissionVC"
    case storeVC                    = "StoreVC"
    case signSuccessVC              = "SignSuccessVC"
    case merchandiseInfoVC          = "MerchandiseInfoVC"
    case voucherInfoVC              = "VoucherInfoVC"
    case alertPopupVC               = "AlertPopupVC"
    case choicePostTypeVC           = "ChoicePostTypeVC"
    case profileVerifyStep1VC       = "ProfileVerifyStep1VC"
    case profileVerifyStep2VC       = "ProfileVerifyStep2VC"
    case profileVerifyStep3VC       = "ProfileVerifyStep3VC"
    case poTaskVC                   = "PoTaskVC"
    case idCameraVC                 = "IDCameraVC"
    case profileAuditingVC          = "ProfileAuditingVC"
    case jobContentVC               = "JobContentVC"
    case surveyVC                   = "SurveyVC"
    case contactRecordsFilterVC     = "ContactRecordsFilterVC"
    case dressingRoomVC             = "DressingRoomVC"
    
}

/// 畫面過場型態
enum TransitionType {
    case none
    case push
    case present
}

///
enum BrowseStyle: String {
    case none = ""
    case safari = "0"
    case webView = "1"
    case outsideWeb = "2"
}

/// 圖片上傳 Type
enum PhotoUseType: String {
    case resume         = "1"
    case job            = "2"
    case compCert       = "3"
    case compIDCard     = "5"
    case talkRecord     = "6"
    case caseIDCard     = "7"
    case caseProfile    = "8"
    case article        = "9"
    case nonageSixteen  = "10"
    case agreement      = "11"
    case nonageEighteen = "12"
    case compDetail     = "13"
}

/// 畫面名稱
enum VCName {
    case none
    case alert
    case alert2
    case poJob
    case poTask
    case hirerInfo
    case service
    case stoodUp
    case remindReplyBK
    case resumeSchool
    case applyVC
    case welcome
    case profileVerifyStep1
    case profileVerifyStep2
    case profileVerifyStep3
    case resume
    case articleContent
}

/// api在什麼情況下執行
enum SourcePage: String {
    case talkRecordLoad             = "1" // 聊天室讀取
    case jobCenterLoad              = "2" // 職缺列表讀取
    case talkRecordReply            = "3" // 聊天室回覆
    case jobCenterReply             = "4" // 職缺列表回覆
}

// 首次進入app相關流程追蹤名稱
enum FirstEventName: String {
    case F_guide_p1                       = "F_guide_p1"
    case F_guide_p2                       = "F_guide_p2"
    case F_guide_notification             = "F_guide_notification"
    case F_choose_mode                    = "F_choose_mode"
    case F_click_worker_mode              = "F_click_worker_mode"
    case F_click_hirer_mode               = "F_click_hirer_mode"
    case F_job_list                       = "F_job_list"
    case F_register_way                   = "F_register_way"
    case F_click_FB_register              = "F_click_FB_register"
    case F_click_mobile_register          = "F_click_mobile_register"
    case F_click_pass_register            = "F_click_pass_register"
    case F_FB_authorize_done              = "F_FB_authorize_done"
    case F_FB_login_done                  = "F_FB_login_done"
    case F_FB_number                      = "F_FB_number"
    case F_click_FB_message               = "F_click_FB_message"
    case F_FB_verify                      = "F_FB_verify"
    case F_FB_verify_done                 = "F_FB_verify_done"
    case F_FB_jobmanage                   = "F_FB_jobmanage"
    case F_mobile_number                  = "F_mobile_number"
    case F_click_mobile_message           = "F_click_mobile_message"
    case F_mobile_verify                  = "F_mobile_verify"
    case F_mobile_verify_done             = "F_mobile_verify_done"
    case F_mobile_jobmanage               = "F_mobile_jobmanage"
    case F_pass_register_jobmanage        = "F_pass_register_jobmanage"
}

// 聯絡記錄頁的篩選
enum ContactTags: Int, CaseIterable {
    case all            = 0
    case apply
    case interview
    case onboard
}

// 公告種類
enum AnnoID: String {
    case none                     = ""           // 無
    case workerRules              = "1"          // 打工守則
    case stoodUpAlert             = "2"          // 放鳥警告
    case tmpDisableAccount        = "3"          // 暫時停權
    case permDisableAccount       = "4"          // 永久停權
    // 數字5是，懲罰機制說明，目前沒使用
    case termsUpdate              = "6"          // 小雞條款更新
    case underLegalAge            = "7"          // 未滿16歲
    case newFeature               = "8"          // 新功能
    case termsOfUse               = "9"          // 同意使用條款
    case filterTip                = "10"         // 篩選功能介紹
    case hideResumeInContact      = "11"         // 聯絡記錄列表的隱藏履歷介紹
}

/// Alert View種類
enum AlertViewInfoID: String {
    case stoodUp            = "1"
    case bookingInterview   = "2"
}

// 聊天列表狀態
enum GroupStatus: String {
    case normal         = "1"   // 正常
    case suspension     = "2"   // 停權
    case block          = "3"   // 封鎖
    case close          = "4"   // 職缺已關閉
    case delete         = "5"   // 職缺已刪除
}

/// 聊天列表官方帳號狀態
enum SocialStatus: String {
    case normal         = "0"   // 正常
    case official       = "1"   // 官方
}

// 提示條樣式
enum HintID: String {
    case none                     = "0"
    case workerInterviewHelp      = "1" // 求職面試幫手
    case hirerInterviewHelp       = "2" // 雇主面試幫手
    case overTalkHalfMaximum      = "3" // 對話超過當月上限一半
    case overTalkMaximun          = "4" // 對話超過當月上限
    case hideResume               = "5" // 隱藏履歷提示
}

// 面試回報狀態
enum ReplyAttendanceStatus: String {
    case none                = "0"       // 無
    case confirming          = "1"       // 需顯示回報畫面
    case done                = "2"       // 已回報
}

// 聊天室上方提示條樣式
enum TalkRecordTopTipType: String {
    case none                = "0"       // 無
    case replyApply          = "1"       // 小橘，雇主模式，提示要回覆對方應徵
    case waitInterviewReply  = "2"       // 小橘，送出面試，待對方確認中
    case checkInterview      = "3"       // 小黃，敲定面試，提示面試時間
    case interviewResult     = "4"       // 小黃，標記面試出席結果
    case hideResume          = "5"       // 黃底，燈泡icon
}

// 聊天列表tag樣式
enum ContactRecordsTagType: String {
    case none                = "0"       // 無
    case lightGray           = "1"       // 淺灰
    case darkGray            = "2"       // 深灰
    case black               = "3"       // 黑，目前沒用到 5/23
    case orange              = "4"       // 橘
    case red                 = "5"       // 紅
}

// 面試出席狀態
enum AttendanceStatus: String {
    case attended           = "2"       // 有出席
    case advised            = "4"       // 有告知取消
    case stoodUp            = "5"       // 放鳥
}

// 履歷信用標籤樣式
enum CreditTag: Int {
    case none           = 0
    case great          = 1
    case stoodUp        = 2
}

// api回傳400的顯示樣式
enum ErrorTipType: Int {
    case top        = 1     // 上方小黑條
    case popup      = 2     // popup Alert
}

// 約時間功能的type
enum BookingType: Int {
    case none           = 0
    case interview      = 1     // 約面試
    case onBoard        = 2     // 約上工
}

/// 職缺列表區塊
enum JobListType: Int {
    case normal         = 0
    case promote        = 1
    case ad         
}

/// 職缺列表header action type
enum JobListHeaderActionType: Int {
    case normal         = 1
    case disable
}

/// 推播提醒類別
enum PushType: String {
    case workerGetMsg       = "1" // 求職者收到詢問
    case hirerGetMsg        = "2" // 雇主收到詢問
    case hirerGetApply      = "3" // 雇主收到應徵
    case systemMsg          = "4" // 系統提醒
    case jobSubscribe       = "5" // 職缺訂閱通知
    case signIn             = "6" // 簽到提醒
}

// 推播開關狀態
enum PushStatus: String {
    case on = "1"
    case off = "2"
}


// MARK: - Struct ------------------------------------------------------------------------
struct UserMode {
    /// 1
    static let user: String     = "1"
    /// 2
    static let hirer: String    = "2"
}

//struct PushType {
//    static let userMsg: String      = "1"
//    static let hirerMsg: String     = "2"
//    static let hirerJob: String     = "3"
//    static let systems : String     = "4"
//    static let subscribe : String   = "5"
//}

/// tabBar的index
struct Index {
    // worker tab
    static let workerJobList             = 0
    static let caseList                  = 1
    static let collectList               = 2
    static let community                 = 2
    static let workerContactRecord       = 3
    static let workerSetting             = 4
    
    // hirer tab
    static let jobCenter                 = 0
    static let hirerContactRecord        = 1
    static let hirerSetting              = 2
    
    // jobCenterVC
    static let publishJobList            = 0
    static let draftJobList              = 1
    
}

struct Action {
    static let click        = "click"
    static let impression   = "impression"
}

struct RegType {
    static let fb =     "2"
    static let mobile = "3"
    static let apple = "4"
}

struct StringCodable: Codable {
    var value: String = ""
    var text: String = ""
    var type: String? = ""
}

struct CellData: Equatable {
    init(cellType: XibType) {
        self.cellType = cellType
    }
    
    var cellType: XibType
    var cellName = ""
    var cellName2 = ""
    var titleStr = ""
    var errorText = ""
    
    var subTitleStr = ""
    var subTitleStr2 = ""
    
    var textFieldStr = ""
    var textFieldStr2 = ""
    
    var id = ""
    
    var contentStr = ""
    
    var placeholder = ""
    var placeholder2 = ""
    
    var tipStr = ""
    var alertTitle = ""
    
    var iconName = ""
    var iconColor = UIColor.black
    
    var imageStr = ""
    
    var isHiddenHr = true
    var isHiddenIcon = true
    var isHiddenImage = true
    var isHiddenView = true
    
    var text = ""
    var text2 = ""
    var value = ""
    var value2 = ""
    
    var linkArray = [String]()
    var stringArray = [String]()
    var selectedArray = [TextValueStruct]()
    var companyName: String?
    var address: String?
    var area = ""
    var date = ""
    var mapPoint = ""
    /// 緯度
    var lat = ""
    /// 經度
    var lng = ""
    
    var keyboardType: UIKeyboardType? = .default
    var bookingType: BookingType?
    var isDisable: Bool?
    
    var postType = PostType.job
    var isOptional = false
    var textMax = 0
}

struct UI {
    /// JobList篩選橫條的高度
    static let searchBarHeight: CGFloat = 48
    /// JobList訂閱view的高度
    static let subscribeViewHeight: CGFloat = 44
    /// JobCenter頂端menuBar的高度
    static let menuBarHeight: CGFloat = 48
    /// JobCenter錯誤提示view的高度
    static let errorTipViewHeight: CGFloat = 48
    /// topBar高度 ex. 提示條
    static let topBarH: CGFloat = 44
    /// 回覆面試結果畫面的高度
    static let replyIVH: CGFloat = 116
    /// 聊天室發送訊息框的高度
    static let talkBottomBarH: CGFloat = 60
    /// 聊天室快速回覆框的高度
    static let quickReplyViewH: CGFloat = 50
    /// slideView Header高度
    static let slideHeaderH: CGFloat = 60
    /// large header 高度
    static let largeHeaderH: CGFloat = 106
    /// 啾幣頁面，頁籤高度
    static let pagingMenuH: CGFloat = 85
    /// SnackBar Height
    static let snackBarH: CGFloat = 52
    /// BlackSnackBar Height
    static let blackSnackBarH: CGFloat = 34
}

// 提示樣式＆文字
struct Hint {
    var id = HintID.none
    var text = ""
    var annoID = AnnoID.none
}

/// 鍵盤資料
struct KeyboardInfo {
    var animationCurve: UIView.AnimationCurve
    var animationOptions: UIView.AnimationOptions
    var animationDuration: Double
    var isLocal: Bool
    var frameBegin: CGRect
    var frameEnd: CGRect
}

extension KeyboardInfo {
    init?(_ notification: NSNotification) {
        guard notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillHideNotification else { return nil }
        
        let u = notification.userInfo!
        animationCurve = UIView.AnimationCurve(rawValue: u[UIWindow.keyboardAnimationCurveUserInfoKey] as! Int)!
        animationOptions = UIView.AnimationOptions(rawValue: UInt(animationCurve.rawValue))
        animationDuration = u[UIWindow.keyboardAnimationDurationUserInfoKey] as! Double
        isLocal = u[UIWindow.keyboardIsLocalUserInfoKey] as! Bool
        frameBegin = u[UIWindow.keyboardFrameBeginUserInfoKey] as! CGRect
        frameEnd = u[UIWindow.keyboardFrameEndUserInfoKey] as! CGRect
    }
}
