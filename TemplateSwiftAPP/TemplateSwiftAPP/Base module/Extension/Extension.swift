//
//  Extension.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

/// MARK: - 颜色扩展
extension UIColor {
    class func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
    
    class func rgba(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
        return color
    }
}

/// MARK: - 图片扩展
extension UIImage {
    class func contentOfURL(link: String) -> UIImage {
        let url = URL.init(string: link)!
        var image = UIImage()
        do {
            let data = try Data.init(contentsOf: url)
            image = UIImage.init(data: data)!
        } catch {
            print("Error downloading images")
        }
        return image
    }
}

/// MARK: - Data扩展
extension Data {
    mutating func append(_ string: String) {
        guard let data = string.data(using: .utf8) else {
            return
        }
        append(data)
    }
}

/// MARK: - 字符串扩展
extension String {
    /// 时间戳转化成日期：yyyy-MM-dd HH:mm:ss
    static func timeStampToDate(timeStamp: TimeInterval) -> String {
        // 时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let dfmatter = DateFormatter()
        // yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
}

/// MARK: - 判断设备类型
extension UIDevice {
    
    /// 4/4s
    class func is_iPhone4() -> Bool {
        if UIScreen.main.bounds.height == 480 && UIScreen.main.bounds.width == 320 {
            return true
        }
        return false
    }
    
    /// 5/5s/5c/se
    class func is_iPhone5() -> Bool {
        if UIScreen.main.bounds.height == 568 && UIScreen.main.bounds.width == 320 {
            return true
        }
        return false
    }
    
    /// 6/6s/7/8
    class func is_iPhone678() -> Bool {
        if UIScreen.main.bounds.height == 667 && UIScreen.main.bounds.width == 375 {
            return true
        }
        return false
    }
    
    /// 6+/7+/8+
    class func is_iPhone678Plus() -> Bool {
        if UIScreen.main.bounds.height == 736 && UIScreen.main.bounds.width == 414 {
            return true
        }
        return false
    }
    
    /// iPhoneX
    class func is_iPhoneX() -> Bool {
        if UIScreen.main.bounds.height == 812 && UIScreen.main.bounds.width == 375 {
            return true
        }
        return false
    }
    
    /// iPhoneXR
    class func is_iPhoneXR() -> Bool {
        if UIScreen.main.bounds.height == 896 && UIScreen.main.bounds.width == 414 {
            return true
        }
        return false
    }
    
    /// iPhoneXS
    class func is_iPhoneXS() -> Bool {
        if UIScreen.main.bounds.height == 812 && UIScreen.main.bounds.width == 375 {
            return true
        }
        return false
    }
    
    /// iPhoneXSMax
    class func is_iPhoneXSMax() -> Bool {
        if UIScreen.main.bounds.height == 896 && UIScreen.main.bounds.width == 414 {
            return true
        }
        return false
    }
}
