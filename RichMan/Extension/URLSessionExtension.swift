//
//  URLSessionExtension.swift
//  Parttime
//
//  Created by 許秉翔 on 2017/9/29.
//  Copyright © 2017年 許秉翔. All rights reserved.
//

import Foundation
import AdSupport

// - HTTP Methods
enum HttpMethod: String {
    case  GET
    case  POST
    case  PATCH
    case  DELETE
    case  UPLOAD
}

// - 請求錯誤分類
enum requestErrorType {
    case error          // - 抓取錯誤(可能timeout時間超過)
    case data           // - data錯誤
    case json           // - json解析失敗
    case unknown        // - 不明錯誤
    case success        // - json解析成功
    case statusCode     // - statusCode錯誤
    case message        // - statusCode為400, 406時，可能會回傳訊息
    case editMessage    // - 編輯資料頁，回傳errorText
    case contentMessage // - VC內文錯誤訊息
}

/// statusCode 400, 錯誤訊息type
enum ErrorMsgType: Int {
    case topTip     = 1
    case edit       = 2
    case content    = 3
}

// 撈取Api回傳格式用，射後不理用
// 如要解析data的回傳，不要用，避免api回傳的格式不同，造成解析失敗
struct ForTestCodable: Codable {
    var statusCode: Int?
    var message: String?
    
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case message
    }
}


struct BaseCodable: Codable {
    // 基本值
    var status_code: Int
    var statusCode: Int?
    var data: Data?
    var message: String?
    var messages: [Messages?]?
    
    // 非長態
    var interview_id: Int?
    
    struct Messages: Codable {
        var contact_mobile: String?
        var booking_datetime: String?
        var booking_address: String?
        var contact_name: String?
        var remark: String?
        var booking_type: String?
    }
    
    struct Data: Codable {
        var popup_title: String?
        var popup_content: String?
        var popup_button_content: String?
        var popup_img_url: String?
    }
}

struct ForPhotoCodable: Codable {
    let statusCode: Int?
    let data: [Datum]?
    let message: String?
    let errorType: Int?
    let photoLink: String?
    let photoID: Int?
    let isBlockAudit: Bool?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case errorType = "error_type"
        case photoLink = "photo_link"
        case photoID = "photo_id"
        case data, message, isBlockAudit
    }
    
    struct Datum: Codable {
        let photoLink: String?
        let photoID: Int?
        let auditedContent: String?

        enum CodingKeys: String, CodingKey {
            case photoLink = "photo_link"
            case photoID = "photo_id"
            case auditedContent = "audited_content"
        }
    }
}

/// 新的api delegate
protocol LoadApiDelegate: NSObjectProtocol {
    
    // 資料讀取完成
    func apiRequestSuccess(httpMethod: HttpMethod,
                           apiURL: Api)
    // 資料讀取錯誤
    func apiRequestFailed(httpMethod: HttpMethod,
                          apiURL: Api,
                          errorType: requestErrorType,
                          message: String?)
    // 資料讀取完成，需傳輸
    func apiRequestSuccessWithData(httpMethod: HttpMethod,
                                   apiURL: Api,
                                   info: [AnyHashable : Any]?)
}

extension LoadApiDelegate {
    func apiRequestSuccessWithData(httpMethod: HttpMethod,
                                   apiURL: Api,
                                   info: [AnyHashable : Any]?) {}
}

/// 舊的api delegate
protocol ApiDelegate:NSObjectProtocol {
    
    //資料讀取完成
    func apiRequestSuccess()
    //資料讀取錯誤
    func apiRequestFailed(_ errorType:requestErrorType)
    //資料讀取錯誤(有訊息)
    func apiRequestFailedWithMessage(_ message:String)
    //操作動作成功
    func actionRequestSuccess()
    //操作動作時錯誤
    func actionRequestFailed(_ errorType:requestErrorType)
    //操作動作時錯誤(有訊息)
    func actionRequestFailedWithMessage(_ message:String)
    
}

class HttpClient {
    let requestTimeout: TimeInterval = 10
    var okStatusCode:[Int] = [200,400,406,403]
    
    
    // MARK: - POST
    func post<T: Decodable>(url: String = APIURL, api: String, post: [String: Any], codable: T.Type , callback: @escaping ( _ decoder: T?, _ errorType: requestErrorType) -> Void) {
        
        let url:URL = URL(string: APIURL + api)!
        var httpBody:[String: Any] = [:]
        
        httpBody.updateValue(APP_DEVICE, forKey: "device_model")
        httpBody.updateValue(APP_VERSION, forKey: "app_version")
        httpBody.updateValue(APP_PUSH_ID, forKey: "push_token")
        httpBody.updateValue(APP_OS, forKey: "os_version")
        
        if let m_id = Defaults[.userId] {
            httpBody.updateValue(m_id, forKey: "m_id")
        }
        httpBody.updateValue(USER_FROM, forKey: "from")
        if let login_key = Defaults[.userKey] {
            httpBody.updateValue(login_key, forKey: "login_key")
        }
        if let uuid = Defaults[.uuid] {
            httpBody.updateValue(uuid, forKey: "device_id")
        }
        if let user_mode = Defaults[.userMode] {
            httpBody.updateValue(user_mode, forKey: "user_mode")
        }
        if let aid = Defaults[.aid] {
            httpBody.updateValue(aid, forKey: "aid")
            if let aidTime = Defaults[.aidTime] {
                httpBody.updateValue(aidTime, forKey: "aid_time")
            }
        }
        httpBody.updateValue(APP_AD_ID, forKey: "google_ad_id")
        
        for i in post {
            httpBody.updateValue(i.value, forKey: i.key)
        }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData , timeoutInterval: requestTimeout)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: httpBody, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            //錯誤處理
            var httpBodyStr:String = ""
            for i in httpBody {
                httpBodyStr = httpBodyStr + "\(i.key)=\(i.value)&"
            }
            request.httpBody = httpBodyStr.data(using: .utf8)
        }
        DispatchQueue(label: api).async {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // - error
                guard error == nil else {
                    DispatchQueue.main.async {
                        print("post error: \(String(describing: error))")
                        callback(nil, requestErrorType.error)
                    }
                    return
                }
                
                // - data error
                guard let data = data else {
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.data)
                    }
                    return
                }
                
                print("post url: \(url)")
//                print("post httpBody: \(httpBody)")
                let httpBodyStr = String(data: request.httpBody!, encoding: String.Encoding.utf8)!
                print("post httpBody data: \(httpBodyStr)")
                let debugStr = String(data: data, encoding: String.Encoding.utf8)!
                print("post response data: \(debugStr)")
                
                callSlackForCafe(method: .POST, apiUrl: "\(url)", 
                                 data: "\(httpBody)")
                
                
                // - http status code error
                if let httpResponse = response as? HTTPURLResponse {
                    if !self.okStatusCode.contains(httpResponse.statusCode) {
                        DispatchQueue.main.async {
                            print("httpResponse.statusCode: \(httpResponse.statusCode)")
                            callback(nil, requestErrorType.statusCode)
                        }
                        return
                    }
                }
                
                // Json parsing
                do {
                    let decoder = try JSONDecoder().decode(codable, from: data)
                    DispatchQueue.main.async {
                        callback(decoder, requestErrorType.success)
                    }
                } catch {
                    // Json parse failed
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.json)
                    }
                    let msg = "\n*** API decode error ***:\n\(error)"
                    callSlackWebhook(api: api, message: msg, param: "\(httpBody)", response: debugStr)
                    print("\(msg)")
                }
            }
            task.resume()
        }
    }
    
    // MARK: - GET
    func get<T: Decodable>(url: String = APIURL, api: String, post: [String: String], codable: T.Type , callback: @escaping ( _ decoder: T?, _ errorType: requestErrorType) -> Void) {
        
        var httpBody:String = ""
        
        httpBody = httpBody + "app_version=" + APP_VERSION + "&"
        
        if let m_id = Defaults[.userId] {
            httpBody = httpBody + "m_id=" + m_id + "&"
        }
        httpBody = httpBody + "from=" + USER_FROM + "&"
        if let login_key = Defaults[.userKey] {
            httpBody = httpBody + "login_key=" + login_key + "&"
        }
        if let uuid = Defaults[.uuid] {
            httpBody = httpBody + "device_id=" + uuid + "&"
        }
        if let user_mode = Defaults[.userMode] {
            httpBody = httpBody + "user_mode=" + user_mode + "&"
        }
        if let aid = Defaults[.aid] {
            httpBody = httpBody + "aid=" + aid + "&"
            
            if let aidTime = Defaults[.aidTime] {
                httpBody = httpBody + "aid_time=" + aidTime + "&"
            }
        }
        
        httpBody += "google_ad_id=" + APP_AD_ID + "&"
        
        for i in post {
            httpBody = httpBody + "\(i.key)=\(i.value)&"
        }
        //let url:URL = URL(string: APIURL + api + "?" + httpBody)!
        let urlTmp = APIURL + api + "?" + httpBody
        let urlStr = urlTmp.urlEncode
        let url:URL = URL(string: urlStr)!
        //print("request url: \(url)")
        
        callSlackForCafe(method: .GET, apiUrl: "\(url)", data: "nil")
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData , timeoutInterval: requestTimeout)
        request.httpMethod = "GET"
        DispatchQueue(label: api).async {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                print("ApiUrl: \(url)")
                
                // - error
                guard error == nil else {
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.error)
                        postErrorLog(apiName: api,
                                     content: "requestErrorType.error: \(String(describing: error))", 
                                     type: .GET, 
                                     params: "\(post)")
                    }
                    return
                }
                
                // - data error
                guard let data = data else {
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.data)
                    }
                    return
                }
                
                // 看data log
                let debugStr = String(data:data, encoding: String.Encoding.utf8)!
                //print("get response data: \(debugStr)")
                
                // - http status code error
                if let httpResponse = response as? HTTPURLResponse {
                    print("http statusCode: \(httpResponse.statusCode)")
                    
                    if !self.okStatusCode.contains(httpResponse.statusCode) {
                        DispatchQueue.main.async {
                            callback(nil, requestErrorType.statusCode)
                        }
                        return
                    }
                }
                
                // Json parsing
                do {
                    let decoder = try JSONDecoder().decode(codable, from: data)
                    DispatchQueue.main.async {
                        callback(decoder, requestErrorType.success)
                    }
                } catch {
                    // Json parse failed
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.json)
                    }
                    let msg = "\n*** API decode error ***:\n\(error)"
                    callSlackWebhook(api: api, message: msg, param: httpBody, response: debugStr)
                    print("\(msg)")
                }
            }
            task.resume()
        }
    }
    
    // MARK: - PATCH
    func patch<T: Decodable>(url: String = APIURL, api: String, post: [String: Any], codable: T.Type , callback: @escaping ( _ decoder: T?, _ errorType: requestErrorType) -> Void) {
        
        let url:URL = URL(string: APIURL + api)!
        var httpBody:[String: Any] = [:]
        
        httpBody.updateValue(APP_VERSION, forKey: "app_version")
        
        if let m_id = Defaults[.userId] {
            httpBody.updateValue(m_id, forKey: "m_id")
        }
        httpBody.updateValue(USER_FROM, forKey: "from")
        if let login_key = Defaults[.userKey] {
            httpBody.updateValue(login_key, forKey: "login_key")
        }
        if let uuid = Defaults[.uuid] {
            httpBody.updateValue(uuid, forKey: "device_id")
        }
        if let user_mode = Defaults[.userMode] {
            httpBody.updateValue(user_mode, forKey: "user_mode")
        }
        if let aid = Defaults[.aid] {
            httpBody.updateValue(aid, forKey: "aid")
            if let aidTime = Defaults[.aidTime] {
                httpBody.updateValue(aidTime, forKey: "aid_time")
            }
        }
        httpBody.updateValue(APP_AD_ID, forKey: "google_ad_id")
        
        for i in post {
            httpBody.updateValue(i.value, forKey: i.key)
        }
        
        
        // test
//        let dict = ["test1": "第一", "test2": "第二"]
//        httpBody.updateValue(dict, forKey: "testObject")
//        
//        let ary = ["Str1", "Str2"]
//        httpBody.updateValue(ary, forKey: "testAry")
        
//        let ary1 = [dict, dict]
//        httpBody.updateValue(ary1, forKey: "testAry1")
        
//        var selectedArray = [TeachItemData.TeachSubItemData]()
//        var tmp = TeachItemData.TeachSubItemData()
//        tmp.value = "10201"
//        tmp.text = "國文(語)"
//        selectedArray.append(tmp)
//        tmp.value = "10299"
//        tmp.text = "Swift"
//        selectedArray.append(tmp)
//        
//        var tmpAry = [[String: Any]]()
//        selectedArray.forEach { selData in
//            tmpAry.append(selData.dictionary)
//        }
//        
//        httpBody.updateValue(tmpAry, forKey: "teach_skill")
        
        
        
        // test end
        
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData , timeoutInterval: requestTimeout)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: httpBody, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            //錯誤處理
            var httpBodyStr:String = ""
            for i in httpBody {
                httpBodyStr = httpBodyStr + "\(i.key)=\(i.value)&"
            }
            request.httpBody = httpBodyStr.data(using: .utf8)
            
            print("patch JSONSerialization error: \(error)")
        }
        DispatchQueue(label: api).async {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // - error
                guard error == nil else {
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.error)
                        print("抓取錯誤(可能timeout時間超過)")
                    }
                    return
                }
                
                // - data error
                guard let data = data else {
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.data)
                    }
                    return
                }
                
                print("patch task url: \(url)")
                print("patch task httpBody: \(httpBody)")
                
                let httpBodyStr = String(data:request.httpBody!, encoding: String.Encoding.utf8)!
                print("patch httpBody data: \(httpBodyStr)")
                
                
                let debugStr = String(data:data, encoding: String.Encoding.utf8)!
                print("patch response data: \(debugStr)")
                
                callSlackForCafe(method: .PATCH, apiUrl: "\(url)", 
                                 data: "\(httpBody)")
                
                // - http status code error
                if let httpResponse = response as? HTTPURLResponse {
                    if !self.okStatusCode.contains(httpResponse.statusCode) {
                        DispatchQueue.main.async {
                            callback(nil, requestErrorType.statusCode)
                        }
                        return
                    }
                }
                
                // Json parsing
                do {
                    let decoder = try JSONDecoder().decode(codable, from: data)
                    DispatchQueue.main.async {
                        callback(decoder, requestErrorType.success)
                    }
                } catch {
                    // Json parse failed
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.json)
                    }
                    let msg = "\n*** API decode error ***:\n\(error)"
                    callSlackWebhook(api: api, message: msg, param: "\(httpBody)", response: debugStr)
                    print("\(msg)")
                }
            }
            task.resume()
        }
    }
    
    // MARK: - UPLOAD
    func upload<T: Decodable>(url: String = APIURL, api: String, post: [String: String], postData: [String: Data], codable: T.Type , callback: @escaping ( _ decoder: T?, _ errorType: requestErrorType) -> Void) {
        
        let url:URL = URL(string: APIURL + api)!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData , timeoutInterval: 20)
        request.httpMethod = "POST"
        
        let boundary = "Boundary+\(arc4random())\(arc4random())"
        var body = Data()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var param:[String: String] = [:]
        
        param.updateValue(APP_VERSION, forKey: "app_version")
        
        if let m_id = Defaults[.userId] {
            param.updateValue(m_id, forKey: "m_id")
        }
        param.updateValue(USER_FROM, forKey: "from")
        if let login_key = Defaults[.userKey] {
            param.updateValue(login_key, forKey: "login_key")
        }
        if let uuid = Defaults[.uuid] {
            param.updateValue(uuid, forKey: "device_id")
        }
        if let user_mode = Defaults[.userMode] {
            param.updateValue(user_mode, forKey: "user_mode")
        }
        if let aid = Defaults[.aid] {
            param.updateValue(aid, forKey: "aid")
            if let aidTime = Defaults[.aidTime] {
                param.updateValue(aidTime, forKey: "aid_time")
            }
        }
        param.updateValue(APP_AD_ID, forKey: "google_ad_id")
        
        for (key, value) in param {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
        for (key, value) in post {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
        
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let timeStamp = String(timeInterval)
        
        for (key, value) in postData {
            var dataTmp = value
            print("壓縮前, \(dataTmp.printSize())")
            
            
            if dataTmp.printSize().compare("5", options: .numeric) == .orderedDescending {
                // data還原image會變成未壓縮前的圖片大小
                var image = UIImage(data: dataTmp) ?? UIImage()
                
                var size = CGSize()
                size.width = 2000
                size.height = 2000 * (image.size.height / image.size.width)
                image = image.kf.resize(to: size)
                print("resize image width: \(image.size.width), image height: \(image.size.height)")
                
                if let compressionData = image.jpegData(compressionQuality: 0.25) {
                    dataTmp = compressionData
                }
                
                print("壓縮後, \(dataTmp.printSize())")
            }
            
            // origin
            let photoData = value as NSData
            let imageName = timeStamp + "." + photoData.imageFormat
            var ext = "jpeg"
            if photoData.imageFormat == "png" {
                ext = "png"
            } else if photoData.imageFormat == "gif" {
                ext = "gif"
            }
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(imageName)\"\r\n") //此處放入file name，以隨機數代替，可自行放入
            body.appendString(string: "Content-Type: image/\(ext)\r\n\r\n") //image/png 可改為其他檔案類型 ex:jpeg
            body.append(dataTmp)
            body.appendString(string: "\r\n")
        }
        body.appendString(string: "--\(boundary)--\r\n")
        
        request.httpBody = body
        print("upload body: \(body)")
        print("upload body printSize: \(body.printSize())")
        //print("body data string: \(String(decoding: body, as: UTF8.self))")
        
        DispatchQueue(label: api).async {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // - error
                guard error == nil else {
                    DispatchQueue.main.async {
                        print("debugDescription: \(error.debugDescription)")
                        callback(nil, requestErrorType.error)
                    }
                    return
                }
                
                // - data error
                guard let data = data else {
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.data)
                    }
                    return
                }
                
                print("upload url: \(url)")
                let debugStr = String(data:data, encoding: String.Encoding.utf8)!
                print("upload response data: \(debugStr)")
                
                callSlackForCafe(method: .UPLOAD, apiUrl: "\(url)", 
                                 data: "\(body)")
                
                // - http status code error
                if let httpResponse = response as? HTTPURLResponse {
                    print("http statusCode: \(httpResponse.statusCode)")
                    
                    if !self.okStatusCode.contains(httpResponse.statusCode) {
                        DispatchQueue.main.async {
                            callback(nil, requestErrorType.statusCode)
                        }
                        return
                    }
                }
                
                var slackParam = post
                for (key, value) in param {
                    slackParam.updateValue(value, forKey: key)
                }
                print("slackParam: \(slackParam)")
                //callSlackWebhook(api: api, message: "msg", param: "\(slackParam)", response: debugStr)
                
                // Json parsing
                do {
                    let decoder = try JSONDecoder().decode(codable, from: data)
                    DispatchQueue.main.async {
                        callback(decoder, requestErrorType.success)
                    }
                } catch {
                    // Json parse failed
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.json)
                    }
                    let msg = "\("upload body: \(body)")\n*** API decode error ***:\n\(error)"
                    callSlackWebhook(api: api, message: msg, param: "\(slackParam)", response: debugStr)
                    print("\(msg)")
                }
            }
            task.resume()
        }
    }
    
    // MARK: - DELETE
    func delete<T: Decodable>(url: String = APIURL, api: String, post: [String: String], codable: T.Type , callback: @escaping ( _ decoder: T?, _ errorType: requestErrorType) -> Void) {
        
        var httpBody:String = ""
        
        httpBody = httpBody + "app_version=" + APP_VERSION + "&"
        
        if let m_id = Defaults[.userId] {
            httpBody = httpBody + "m_id=" + m_id + "&"
        }
        httpBody = httpBody + "from=" + USER_FROM + "&"
        if let login_key = Defaults[.userKey] {
            httpBody = httpBody + "login_key=" + login_key + "&"
        }
        if let uuid = Defaults[.uuid] {
            httpBody = httpBody + "device_id=" + uuid + "&"
        }
        if let user_mode = Defaults[.userMode] {
            httpBody = httpBody + "user_mode=" + user_mode + "&"
        }
        if let aid = Defaults[.aid] {
            httpBody = httpBody + "aid=" + aid + "&"
            
            if let aidTime = Defaults[.aidTime] {
                httpBody = httpBody + "aid_time=" + aidTime + "&"
            }
        }
        httpBody += "google_ad_id=" + APP_AD_ID + "&"
        
        for i in post {
            httpBody = httpBody + "\(i.key)=\(i.value)&"
        }
        //let url:URL = URL(string: APIURL + api + "?" + httpBody)!
        let urlTmp = APIURL + api + "?" + httpBody
        let urlStr = urlTmp.urlEncode
        let url:URL = URL(string: urlStr)!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData , timeoutInterval: requestTimeout)
        request.httpMethod = "DELETE"
        DispatchQueue(label: api).async {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // - error
                guard error == nil else {
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.error)
                    }
                    return
                }
                
                // - data error
                guard let data = data else {
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.data)
                    }
                    return
                }
                
                print("delete url: \(url)")
                print("delete httpBody: \(httpBody)")
                let debugStr = String(data:data, encoding: String.Encoding.utf8)!
                print("delete response data: \(debugStr)")
                
                callSlackForCafe(method: .DELETE, apiUrl: "\(url)", 
                                 data: "\(httpBody)")
                
                // - http status code error
                if let httpResponse = response as? HTTPURLResponse {
                    if !self.okStatusCode.contains(httpResponse.statusCode) {
                        DispatchQueue.main.async {
                            callback(nil, requestErrorType.statusCode)
                        }
                        return
                    }
                }
                
                // Json parsing
                do {
                    let decoder = try JSONDecoder().decode(codable, from: data)
                    DispatchQueue.main.async {
                        callback(decoder, requestErrorType.success)
                    }
                } catch {
                    // Json parse failed
                    DispatchQueue.main.async {
                        callback(nil, requestErrorType.json)
                    }
                    let msg = "\n*** API decode error ***:\n\(error)"
                    callSlackWebhook(api: api, message: msg, param: httpBody, response: debugStr)
                    print("\(msg)")
                }
                
            }
            task.resume()
        }
    }
    
    // MARK: - DOWNLOAD
    func download(url: URL, callback: @escaping (_ url:URL?, _ errorType: requestErrorType) -> Void) {
        
        let request = URLRequest(url:url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval:10)
        var ext = String(describing: url).components(separatedBy: ".")
        
        DispatchQueue.global().async {
            URLSession.shared.downloadTask(with: request) { (location, response, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                         callback(nil, requestErrorType.error)
                    }
                    return
                }
                
                let interval:TimeInterval = Date().timeIntervalSince1970
                let locationPath = location!.path
                
                let documents:String = NSHomeDirectory() + "/Documents/\(Int(interval)).\(ext[ext.count-1])"
                let fileManager = FileManager.default
                try! fileManager.moveItem(atPath: locationPath, toPath: documents)
                
                let directoryURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let file = directoryURL.appendingPathComponent("\(Int(interval)).\(ext[ext.count-1])")
                
                DispatchQueue.main.async {
                    callback(file, requestErrorType.success)
                }
            }.resume()
        }
        
    }

}
