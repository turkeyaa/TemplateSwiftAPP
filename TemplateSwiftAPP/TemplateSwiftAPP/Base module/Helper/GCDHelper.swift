//
//  GCDHelper.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/9.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation


class GCDHelper: NSObject {
    
    /// 并发队列
    static func runInGlobalQueue(block: @escaping () -> Void) -> Void {
        DispatchQueue.global().async(execute: block)
    }
    
    /// 主队列
    static func runInMainQueue(block: @escaping () -> Void) -> Void {
        DispatchQueue.main.async(execute: block)
    }
    
    /// 延迟调用
    static func runAfterSecs(secs: UInt, block: @escaping () -> Void) -> Void {
        let deadline: DispatchTime = DispatchTime.init(uptimeNanoseconds: UInt64(secs))
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: block)
    }
    
    /// 自定义串行队列
    
    /// 队列组
    
}
