//
//  LoginNotify.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

let kNotifyLogin            = "kNotifyLogin"
let kNotifyLogout           = "kNotifyLogout"

class LoginNotify {
    
    let center = NotificationCenter()
    
    static let sharedInstance = LoginNotify.init()
    
    // Login successfully notify
    func addLoginObserver(target: Any, selector: Selector) -> Void {
        center.addObserver(target, selector: selector, name: NSNotification.Name(rawValue: kNotifyLogin), object: nil)
    }
    
    func removeLoginObserver(target: Any) -> Void {
        center.removeObserver(target, name: NSNotification.Name(rawValue: kNotifyLogin), object: nil)
    }
    
    func postLoginNotify() -> Void {
        center.post(name: NSNotification.Name(rawValue: kNotifyLogin), object: nil)
    }
    
    /// Logout successfully notify
    func addLogoutObserver(target: Any, selector: Selector) -> Void {
        center.addObserver(target, selector: selector, name: NSNotification.Name(rawValue: kNotifyLogout), object: nil)
    }
    
    func removeLogoutObserver(target: Any) -> Void {
        center.removeObserver(target, name: NSNotification.Name(rawValue: kNotifyLogout), object: nil)
    }
    
    func postLogoutNotify() -> Void {
        center.post(name: NSNotification.Name(rawValue: kNotifyLogout), object: nil)
    }
}
