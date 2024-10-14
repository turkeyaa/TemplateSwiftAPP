//
//  WorkSpace.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class WorkSpace: NSObject {
    
    var user: User
    var appPreference: AppPreference
    
    static let sharedInstance = WorkSpace()
    private override init() {
        user = User()
        appPreference = AppPreference()
    }
    
    static func currentUser() -> User {
        return WorkSpace.sharedInstance.user
    }
    
    /// 登录
    func onLogIn(api: BaseRestApi, account: String, password: String) -> Void {
        
        let userApi = api as! UserInfo_Post
        user = userApi.user!
        
        appPreference.account = account
        appPreference.password = password
        appPreference.token = userApi.queryToken()
        appPreference.isLoginSuccess = true
        
        /// 通知
        LoginNotify.sharedInstance.postLoginNotify()
    }
    
    /// 退出
    func onLogOut() -> Void {
        appPreference.isLoginSuccess = false
        
        /// 通知
        LoginNotify.sharedInstance.postLogoutNotify()
    }
}
