//
//  URLHelper.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

let AppStatus_Product = 1     // 正式环境
let AppStatus_Develop = 2     // 开发环境
let AppStatus_Test    = 3     // 测试环境

let APP_STATUS = AppStatus_Product

class URLHelper: NSObject {
    
    static let sharedInstance = URLHelper()
    
    private override init() {
        super.init()
    }
    
    func baseURL() -> String {
        
        // 修改为你们自己的服务器地址即可 - 这是测试用测试用测试用
        if APP_STATUS == AppStatus_Product {
            return "http://106.14.146.99"
        }
        else if APP_STATUS == AppStatus_Develop {
            return "http://localhost:8181"
        }
        else if APP_STATUS == AppStatus_Test {
            return "http://localhost:8181"
        }
        else {
            return ""
        }
    }
    
    func baseImageURL() -> String {
        var url: String = self.baseURL()
        
        if APP_STATUS == AppStatus_Product {
            url += ":8686/"
            url += "images/"
        }
        else if APP_STATUS == AppStatus_Develop {
            url += "/Users/wenhua/Documents/images/"
        }
        else if APP_STATUS == AppStatus_Test {
            url += "/Users/wenhua/Documents/images/"
        }
        else {
            
        }
        return url
    }
    
    func restApiURL(relativeURL: String) -> String {
        var url:String = baseURL()
        url += "/"
        url += relativeURL
        return url
    }
    
    
    func restImageURL() -> String {
        return baseImageURL()
    }
}
