//
//  DeviceUtil.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/26.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

/// 参考类：`Extension.swift` 扩展了判断设备型号
class DeviceUtil: NSObject {
    
    /// 判断是否为刘海屏
    class func is_iPhoneX() -> Bool {
        if UIDevice.is_iPhoneX() || UIDevice.is_iPhoneXS() || UIDevice.is_iPhoneXSMax() || UIDevice.is_iPhoneXR() {
            return true
        }
        return false
    }
}
