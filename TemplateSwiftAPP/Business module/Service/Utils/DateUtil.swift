//
//  DateUtil.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/18.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

/// 时间相关
class DateUtil: NSObject {
    
    /// 时间戳转化成日期：yyyy-MM-dd HH:mm:ss
    static func timeStampToDate(timeStamp: TimeInterval) -> String {
        return String.timeStampToDate(timeStamp: timeStamp)
    }
    
    /// 时间戳转化成日期：MM-dd HH:mm
    static func timeStampToString(timeStamp: TimeInterval) -> String {
        // 时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let dfmatter = DateFormatter()
        // yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="MM-dd HH:mm"
        return dfmatter.string(from: date as Date)
    }
    
    
    
}
