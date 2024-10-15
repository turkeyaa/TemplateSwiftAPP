//
//  URLHelper.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

let AppStatus_Product = 1
let AppStatus_Develop = 2
let AppStatus_Test    = 3

let APP_STATUS = 1

class URLHelper: NSObject {
    
    static let sharedInstance = URLHelper()
    
    private override init() {
        super.init()
    }
    
    func baseURL() -> String {
        
        // use your own IP address
        if APP_STATUS == AppStatus_Product {
//            return "https://github.com/turkeyaa/TemplateSwiftAPP/tree/master/"
            return "https://raw.githubusercontent.com/turkeyaa/TemplateSwiftAPP/refs/heads/master/"
        }
        else if APP_STATUS == AppStatus_Develop {
            return "https://raw.githubusercontent.com/turkeyaa/TemplateSwiftAPP/refs/heads/master/"
        }
        else if APP_STATUS == AppStatus_Test {
            return "https://raw.githubusercontent.com/turkeyaa/TemplateSwiftAPP/refs/heads/master/"
        }
        else {
            return "other"
        }
    }
    
    func baseImageURL() -> String {
        var url: String = self.baseURL()
        
        if APP_STATUS == AppStatus_Product {
            url += "path/images/product"
        }
        else if APP_STATUS == AppStatus_Develop {
            url += "path/images/develop"
        }
        else if APP_STATUS == AppStatus_Test {
            url += "path/images/test"
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
