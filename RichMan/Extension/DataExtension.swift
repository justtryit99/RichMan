//
//  DataExtension.swift
//  Parttime
//
//  Created by hsiang on 2017/10/27.
//  Copyright © 2017年 許秉翔. All rights reserved.
//
import UIKit
import ImageIO

struct ImageHeaderData{
    static var PNG: [UInt8] = [0x89]
    static var JPEG: [UInt8] = [0xFF]
    static var GIF: [UInt8] = [0x47]
    static var TIFF_01: [UInt8] = [0x49]
    static var TIFF_02: [UInt8] = [0x4D]
}

enum ImageFormat : String {
    case PNG = "png"
    case JPEG = "jpg"
    case GIF = "gif"
    case TIFF = "tiff"
    case Unknown = ""
}

extension Data {
    
    //上傳照片使用
    mutating func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
    
    /// 計算Data大小, 單位 MB
    func printSize() -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(self.count))
        
        return string
        
    }
}

extension NSData{
    //檢查圖片副檔名
    var imageFormat:String{
        var buffer = [UInt8](repeating: 0, count: 1)
        self.getBytes(&buffer, range: NSRange(location: 0,length: 1))
        if buffer == ImageHeaderData.PNG {
            return ImageFormat.PNG.rawValue
        } else if buffer == ImageHeaderData.JPEG {
            return ImageFormat.JPEG.rawValue
        } else if buffer == ImageHeaderData.GIF {
            return ImageFormat.GIF.rawValue
        } else if buffer == ImageHeaderData.TIFF_01 || buffer == ImageHeaderData.TIFF_02{
            return ImageFormat.TIFF.rawValue
        } else{
            return ImageFormat.Unknown.rawValue
        }
    }
}

