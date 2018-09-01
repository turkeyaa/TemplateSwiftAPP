//
//  AppPreference.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/1.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class AppPreference: NSObject {
    
    /// 账户
    var account: String = ""
    var password: String = ""
    
    /// 配置
    var isFirstOpen: Bool = false
    var isLoginSuccess: Bool = false
    
    /// token
    var token: String = ""
}
