//
//  UmSDKHelper.swift
//  TemplateSwift
//
//  Created by yuwenhua on 2017/9/21.
//  Copyright © 2017年 DS. All rights reserved.
//

import Foundation
import UIKit

/// 友盟SDK相关
class UmSDKHelper: NSObject {
    
    /*
    var clickItemBlock: BlockItem?
    
    static let sharedInstance = UmSDKHelper()
    private override init() {
        
    }
    
    /// 友盟统计配置
    static func configuAnaly() -> Void {
        UMConfigure.setEncryptEnabled(true)
        UMConfigure.setLogEnabled(true)
        UMConfigure.initWithAppkey(kUmengAppKey, channel: "App Store")
        
        MobClick.setCrashReportEnabled(true)
    }
    
    /// 友盟分享配置
    static func configuShare() -> Void {
        UMSocialManager.default()?.openLog(true)
        UMSocialManager.default()?.umSocialAppkey = kUmengAppKey
        
        UMSocialManager.default()?.setPlaform(.QQ, appKey: kQQAppId, appSecret: kQQAppScrict, redirectURL: "http://mobile.umeng.com/social")
        UMSocialManager.default()?.setPlaform(.sina, appKey: kSinaAppId, appSecret: kSinaAppScrict, redirectURL: "http://mobile.umeng.com/social")
        UMSocialManager.default()?.setPlaform(.wechatSession, appKey: kWechatAppId, appSecret: kWechatAppScrict, redirectURL: "http://mobile.umeng.com/social")
    }
    
    /// 第三方登录相关 - 参考文档：http://dev.umeng.com/social/ios/login-page
        func thirdLogin(type: UMSocialPlatformType, vc: UIViewController, back: @escaping BlockSuccess) -> Void {
        UMSocialManager.default()?.getUserInfo(with: type, currentViewController: vc, completion: { (data, error) in
            print("Third login data: \(data ?? "")")
            let result: UMSocialUserInfoResponse = data as! UMSocialUserInfoResponse
            print(result)
            back(true)
        })
    }
    
    /// 分享相关
    // MARK: - 分享内容
    func share(type: UMSocialPlatformType,title: String, content: String, vc: UIViewController,back: @escaping BlockSuccess) -> Void {
        
        let messageObj: UMSocialMessageObject = UMSocialMessageObject.init()
        messageObj.title = title
        messageObj.text = content
        UMSocialManager.default().share(to: type, messageObject: messageObj, currentViewController: vc, completion: { (data, error) in
            
            if error != nil {
                back(false)
            }
            else {
                back(true)
            }
        })
    }
    
    // MARK: - 分享链接
    func shareURL(type: UMSocialPlatformType,title: String, content: String, urlStr: String, vc: UIViewController,back: @escaping BlockSuccess) -> Void {
        
        let shareObj: UMShareWebpageObject = UMShareWebpageObject.init()
        shareObj.title = title
        shareObj.descr = content
        shareObj.webpageUrl = urlStr
        
        let messageObj: UMSocialMessageObject = UMSocialMessageObject.init()
        messageObj.title = title
        messageObj.text = content
        messageObj.shareObject = shareObj
        UMSocialManager.default().share(to: type, messageObject: messageObj, currentViewController: vc, completion: { (data, error) in
            if error != nil {
                back(false)
            }
            else {
                back(true)
            }
        })
    }
    */
    
}
