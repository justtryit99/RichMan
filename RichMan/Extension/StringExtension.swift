//
//  StringExtension.swift
//  Parttime
//
//  Created by hsiang on 2017/10/26.
//  Copyright © 2017年 許秉翔. All rights reserved.
//

import Foundation
//import TTTAttributedLabel

extension String {
    
    // TODO: 20200131 待理解意思
    /// 取得當前字串符合正規表示法的結果
    ///
    /// - Parameter regex: 正規表示式
    /// - Returns: [[吻合結果字串1]]
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map { result.range(at: $0).location != NSNotFound
                ? nsString.substring(with: result.range(at: $0))
                : ""
            }
        }
    }
    
    // url encode
    var urlEncode:String {
        //return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet(charactersIn: "!*'\\\\();:@&=+$,/?%#[]% ").inverted)
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    // url decode
    var urlDecode :String {
        return self.removingPercentEncoding ?? ""
    }
    
    ///去掉字符串标签
    mutating func filterHTML() -> String?{
        var stringTmp = self as NSString
        let scanner = Scanner(string: stringTmp as String)
        
        var text: NSString?
        while !scanner.isAtEnd {
            
            scanner.scanUpTo("<", into: nil)
            scanner.scanUpTo(">", into: &text)
            
            stringTmp = stringTmp.replacingOccurrences(of: "\(text == nil ? "" : text!)>", with: "") as NSString
        }
        
        return stringTmp as String
    }
    
    /// 是否為空值，增加空格、斷行的判斷
    func isEmpty() -> Bool {
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return str.isEmpty
    }
    
    /// 是否含有中文字元
    func isContainsChineseCharacter() -> Bool {
        for scalar in self.unicodeScalars {
            if scalar.value >= 19968 && scalar.value <= 171941 {
                return true
            }
        }
        return false
    }
    
    //取得文字高度
    func getHeightForText(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    //取得文字寬度
    func getWidthForText(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    /// 轉換成NsRange
    func nsRange(fromRange range : Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    /// 搜尋range轉換成NsRange
    func toNsRange(ofText: String) -> NSRange {
        guard let range = self.range(of: ofText) else {
            return NSRange(location: 0, length: 0)
        }
        return self.nsRange(fromRange: range)
    }
    
    /// 處理需要底線的文字，可開接口來決定是否要粗體
    func addUnderline(text: String) -> NSMutableAttributedString {
        let range = self.toNsRange(ofText: text)
        let atbString = NSMutableAttributedString(string: self)
        atbString.addAttribute(.underlineStyle, value: 1, range: range)
        let font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        atbString.addAttribute(.font, value: font, range: range)
        return atbString
    }
    
    /// 帶入要變形的文字，吐出NSMutableAttributedString，字型為粗體Semibold
    func toAttributedStr(size: CGFloat,
                         color: UIColor,
                         keyword: String = "",
                         keywords: [String]? = nil,
                         imgName: String? = nil) -> NSMutableAttributedString {
        
        
        var myAttribute: [NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: size)]
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 5
        myAttribute[.paragraphStyle] = paragraph
        let attributedString = NSMutableAttributedString(string: self, attributes: myAttribute)
        
        let font = UIFont.boldSystemFont(ofSize: size)
        if let regex = try? NSRegularExpression(pattern: keyword, options: .caseInsensitive) {
            
            let range = NSRange(location: 0, length: self.count)
            
            for match in regex.matches(in: self, options: .withTransparentBounds, range: range) {
                attributedString.addAttribute(.font, value: font,
                                              range: match.range)
                attributedString.addAttribute(.foregroundColor, value: color,
                                              range: match.range)
                // 如果圖片存在，帶入到文字當背景
                if let imgName = imgName, let img = UIImage(named: imgName) {
                    
                    // height: 30, 適用於字型大小 15pt
                    let reImg = img.reSizeImage(reSize: CGSize(width: 20, height: 30))
                    
                    attributedString.addAttribute(.backgroundColor,
                                                  value: UIColor(patternImage: reImg),
                                                  range: match.range)
                }
            }
        }
        
        // 多個字串需變色時
        if let keywords = keywords {
            for word in keywords {
                if let regex = try? NSRegularExpression(pattern: word, options: .caseInsensitive) {
                    
                    let range = NSRange(location: 0, length: self.count)
                    
                    for match in regex.matches(in: self, options: .withTransparentBounds, range: range) {
                        attributedString.addAttribute(.font, value: font,
                                                      range: match.range)
                        attributedString.addAttribute(.foregroundColor, value: color,
                                                      range: match.range)
                        // 如果圖片存在，帶入到文字當背景
                        if let imgName = imgName, let img = UIImage(named: imgName) {
                            
                            // height: 30, 適用於字型大小 15pt
                            let reImg = img.reSizeImage(reSize: CGSize(width: 20, height: 30))
                            
                            attributedString.addAttribute(.backgroundColor,
                                                          value: UIColor(patternImage: reImg),
                                                          range: match.range)
                        }
                    }
                }
            }
        }
        
        return attributedString
    }
    
    // 解析字串連結to Dictionary
    func parserToDic() -> [String: String] {
        var param: [String: String] = [:]
        
        let ary = self.components(separatedBy: "&")
        
        for str in ary {
            let ary2 = str.components(separatedBy: "=")
            if let key = ary2.first, let value = ary2.last, ary2.count == 2 {
                param.updateValue(value, forKey: key)
            }
        }
        return param
    }
    
    /// 取得文字size
    func getSize(font: UIFont, maxSize: CGSize) -> CGSize {
        
        return self.boundingRect(with: maxSize,
                                 options: [.usesLineFragmentOrigin],
                                 attributes: [NSAttributedString.Key.font : font],
                                 context: nil).size
    }
    
    /// 判斷URL是否能開啟
    func verifyUrl() -> Bool {
        if let url = URL(string: self) {
            return UIApplication.shared.canOpenURL(url)
        } else {
            return false
        }
    }
    
    /// 民國年字串轉換成日期
    func TWYearToDate(_ style: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = style
        dateFormatter.locale = Locale(identifier: "zh_Hant_TW") // 設定地區(台灣)
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei") // 設定時區(台灣)
        dateFormatter.calendar = Calendar(identifier: .republicOfChina)
        let date = dateFormatter.date(from: self) ?? Date()
        
        return date
    }
    
    /// iOS吃html含css語法，android吃老式html，iOS吃android語法會異常
    var htmlToAttributedString: NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString(string: "") }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey : Any]
            options = [.documentType: NSAttributedString.DocumentType.html,
                       .characterEncoding: String.Encoding.utf8.rawValue]
            let attributedString = try NSMutableAttributedString(data: data, 
                                                                 options: options,
                                                                 documentAttributes: nil)
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = 3
            attributedString.addAttribute(.paragraphStyle, 
                                          value: paragraph, 
                                          range: NSMakeRange(0, attributedString.length))
            return attributedString
        } catch {
            return NSAttributedString(string: "")
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString.string
    }
    
}

extension TTTAttributedLabel {
    func toStr() -> String {
        if let str = self.text as? String {
            return str
        } else {
            print("轉型錯誤")
            return ""
        }
    }
}

extension Optional {
    var str: String {
        return ((self as? String) != nil) ? self as! String : ""
    }
    
}
