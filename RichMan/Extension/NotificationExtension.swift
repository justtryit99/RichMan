//
//  NotificationExtension.swift
//  Parttime
//
//  Created by JUMP on 2019/4/5.
//  Copyright © 2019 Addcn. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let reloadAttendanceView = Notification.Name("reloadAttendanceView")
    static let updateMyPoint = Notification.Name("updateMyPoint")
    static let tableViewWillDisplay = Notification.Name("tableViewWillDisplay")
    
    /// 此reload會有帶參數判斷更新，不是每次都更新
    static let reloadJobCenterList = Notification.Name("reloadJobCenterList")
    static let updateCaseProfileStatus = Notification.Name("updateCaseProfileStatus")
    
    /// 儲存完職缺，更新職缺列表
    static let refreshJobCenterList = Notification.Name("refreshJobCenterList")
    /// check app完成之後，通知執行事件，目前有TabBarController顯示任務列表tip、雇主banner顯示
    static let checkAppFinish = Notification.Name("checkAppFinish")
    /// 發佈貼文後，reload文章列表
    static let reloadCommunityList = Notification.Name("reloadCommunityList")
    /// 發佈貼文後，回到列表，再到該篇文章
    static let pushNewPostArticle = Notification.Name("pushNewPostArticle")
    /// 內文按讚/留言/刪除留言後，更新列表資料
    static let updateCommunityListNum = Notification.Name("updateCommunityListNum")
    /// 刪除文章後，刪除列表資料
    static let removeCommunityListData = Notification.Name("removeCommunityListData")
    /// 更衣室更新完成後的通知
    static let dressingRoomUpdateFinish = Notification.Name("dressingRoomUpdateFinish")
    /// reload更衣室API
    static let reloadDressingRoom = Notification.Name("reloadDressingRoom")
    /// 儲存履歷完成後的通知
    static let patchResumeDone = Notification.Name("patchResumeDone")
    /// 公司介紹頁收藏動作後，通知收藏列表頁更新
    static let updateCollectCompListCell = Notification.Name("updateCollectCompListCell")
}
