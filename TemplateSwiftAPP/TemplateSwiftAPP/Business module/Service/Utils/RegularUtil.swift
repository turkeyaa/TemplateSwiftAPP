//
//  RegularUtil.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/18.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

/// 正则表达式，验证输入数据正确性
class RegularUtil: NSObject {
    
    static func isPhoneNumber(phone: String) -> Bool {
        if phone.count != 11 {
            return false
        }
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: phone) == true {
            return true
        } else {
            return false
        }
    }
    
    /// todo - 暂未完成
    static func isEmail(email: String) -> Bool {
        return false
    }
    
}
