//
//  DateExtension.swift
//  Parttime
//
//  Created by Mars Lee on 2018/1/26.
//  Copyright © 2018年 Addcn. All rights reserved.
//
import UIKit

extension URL {
    
    //URL後面參數轉陣列
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
    }
    
    /// 判斷URL是否能開啟
    func verify() -> Bool {
        return UIApplication.shared.canOpenURL(self)
    }
}
