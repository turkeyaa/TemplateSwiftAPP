//
//  TopicDetailVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/8/29.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

import MarkdownView

class TopicDetailVC: BaseVC {
    
    var topic: Topic = Topic()
    lazy var bottomView: TopicBottomView = {
        var view = TopicBottomView.init()
        view.clickItemBlock = {
            (index: Int) -> Void in
            self.btnEvent(index: index)
        }
        return view
    }()
    lazy var shareView: ShareView = {
        let titles = ["QQ","微信","新浪微博"]
        let icons = [UIImage.init(named: "app_qq")!,UIImage.init(named: "app_weixin")!,UIImage.init(named: "app_weibo")!]
        let view = ShareView.init(titles: titles, images:icons)
        view.clickItemBlock = {
            (index: Int) -> Void in
            UIHelper.show(title: "分享到\(titles[index])")
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = topic.title
        self.rightIcon(icon: UIImage.init(named: "app_share")!)
        
        /// 初始化
        let md = MarkdownView()
        self.view.addSubview(md)
        self.view.addSubview(bottomView)
        
        md.load(markdown: topic.content)
        md.isScrollEnabled = true
        
        // called when rendering finished
        md.onRendered = { [weak self] height in
            self?.showInfoMessage(hud: "加载成功")
            self?.view.setNeedsLayout()
        }
        
        // called when user touch link
        md.onTouchLink = { [weak self] request in
            guard let url = request.url else { return false }
            
            if url.scheme == "file" {
                return false
            } else if url.scheme == "https" {
//                let safari = SFSafariViewController(url: url)
//                self?.navigationController?.pushViewController(safari, animated: true)
                let webVC = WebVC()
                self?.navigationController?.pushViewController(webVC, animated: true)
                return false
            } else {
                return false
            }
        }
        
        /// 约束
        md.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(-50)
        }
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(50)
        }
        
        bottomView.updateUI(topic: topic)
    }
    
    /// api
    func loaeCommentList() -> Void {
        
    }
    
    /// 交互事件
    func btnEvent(index: Int) -> Void {
        
        if !WorkSpace.sharedInstance.appPreference.isLoginSuccess {
            UIHelper.show(title: "请先登录")
            return
        }
        
        DispatchQueue.global().async {
            
            if index == 0 {
                let api = NewLikeApi.init(topicID: self.topic.topicID!.uuidString)
                api.call(async: true)
                DispatchQueue.main.async {
                    if api.code == .status_ok {
                        UIHelper.show(title: "喜欢成功了")
                        self.topic.likeNum += 1
                    } else {
                        UIHelper.show(title: api.message)
                    }
                }
                
            } else if index == 1 {
                let api = NewCollectApi.init(topicID: self.topic.topicID!.uuidString)
                api.call(async: true)
                DispatchQueue.main.async {
                    if api.code == .status_ok {
                        UIHelper.show(title: "收藏成功了")
                        self.topic.collectNum += 1
                    } else {
                        UIHelper.show(title: api.message)
                    }
                }
                
            } else {
                
                UIHelper.show(title: "todo - 暂未完成")
                /*
                let api = NewCommentApi.init(topicID: self.topic.topicID!.uuidString, content: "写的很好")
                api.call(async: true)
                DispatchQueue.main.async {
                    if api.code == .status_ok {
                        UIHelper.show(title: "喜欢成功了")
                    } else {
                        UIHelper.show(title: api.message)
                    }
                }
                */
            }
        }
    }
    
    override func goNext() {
        self.view.addSubview(shareView)
    }
    
}
