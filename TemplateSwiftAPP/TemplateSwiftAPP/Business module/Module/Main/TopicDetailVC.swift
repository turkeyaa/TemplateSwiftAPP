//
//  TopicDetailVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/8/29.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

//import MarkdownView

class TopicDetailVC: BaseVC {
    
    var topicID: String = ""
    var content: String = ""
    
    private var topic: Topic = Topic()
    lazy var bottomView: TopicBottomView = {
        var view = TopicBottomView.init()
        view.clickItemBlock = {
            (index: Int) -> Void in
            self.btnEvent(index: index)
        }
        return view
    }()
    
    lazy var shareView: ShareView = {
        let titles = ["QQ","微信","朋友圈","QQ空间"]
        let icons = [UIImage.init(named: "app_qq")!,UIImage.init(named: "app_weixin")!,UIImage.init(named: "app_chatTime")!,UIImage.init(named: "app_qqSpace")!]
        let view = ShareView.init(titles: titles, images:icons)
        view.clickItemBlock = {
            (index: Int) -> Void in
            UIHelper.show(title: "分享到\(titles[index])")
            self.umengShare(index: index)
        }
        return view
    }()
    
    lazy var commentListView: TopicCommentListView = {
        let view = TopicCommentListView.init()
        view.clickItemBlock = {
            (index: Int) -> Void in
            self.listCloseBtnEvent(index: index)
        }
        return view
    }()
    
    lazy var commentView: TopicCommentView = {
        let view = TopicCommentView.init()
        view.clickItemBlock = {
            (index: Int) -> Void in
            self.commentEvent(index: index)
        }
        return view
    }()
    
    lazy var md: MarkdownView = {
        let view = MarkdownView(frame: CGRect.init(x: 0, y: Device_nav+Device_status, width: Device_width, height: Device_height-Device_status-Device_nav-50));
        view.isScrollEnabled = true
        
        view.load(markdown: content)
        
//        let path = Bundle.main.path(forResource: "sample", ofType: "md")!
//        let url = URL(fileURLWithPath: path)
//        let markdown = try! String(contentsOf: url, encoding: String.Encoding.utf8)
//        view.load(markdown: markdown, enableImage: true)
        
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1.0
        //        view.load(markdown: "# Hello World!")
        // called when rendering finished
        view.onRendered = { [weak self] height in
            self?.showSuccessMessage(hud: "加载完成")
            self?.view.setNeedsLayout()
        }
        // called when user touch link
        view.onTouchLink = { [weak self] request in
            guard let url = request.url else { return false }
            
            if url.scheme == "file" {
                return false
            } else if url.scheme == "http" {
                let webVC = WebVC()
                self?.navigationController?.pushViewController(webVC, animated: true)
                return false
            } else {
                return false
            }
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rightIcon(icon: UIImage.init(named: "app_share")!)
        
        self.view.addSubview(md)
        self.view.addSubview(bottomView)
        
        /// 约束
        //        md.snp.makeConstraints { (make) in
        //            make.top.left.right.equalTo(0)
        //            make.bottom.equalTo(-50)
        //        }
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(50)
        }
        
        self.loadTopic()
    }
    
    /// api
    func loadTopic() -> Void {
        
        self.showLoadingHUD(hud: "正在加载")
        
        GCDUtil.runInGlobalQueue {
            
            let api = TopicInfo_Get.init(topicID: self.topicID)
            api.call(async: true)
            
            let commentApi = CommentList_Get.init(offset: 0, limit: 100, topicID: self.topicID)
            commentApi.call(async: true)
            
            GCDUtil.runInMainQueue {
                self.hideLoadingHUD()
                if api.code == .status_ok {
                    self.topic = api.topic
                    self.title = api.topic.title
//                    self.md.load(markdown: self.topic.content)
                    self.bottomView.updateUI(topic: self.topic)
                } else {
                    
                }
            }
        }
    }
    
    func addComment(content: String) -> Void {
        
        self.showLoadingHUD(hud: "正在加载")
        
        DispatchQueue.global().async {
            
            let api = NewComment_Post.init(topicID: self.topicID, content: content)
            api.call(async: true)
            
            DispatchQueue.main.async {
                self.hideLoadingHUD()
                if api.code == .status_ok {
                    UIHelper.show(title: "评论成功")
                } else {
                    UIHelper.show(title: api.message)
                }
            }
        }
    }
    
    /// 交互事件
    func btnEvent(index: Int) -> Void {
        
        if !WorkSpace.sharedInstance.appPreference.isLoginSuccess {
            UIHelper.show(title: "请先登录")
            return
        }
        
        DispatchQueue.global().async {
            
            if index == 0 {
                let api = NewLike_Post.init(topicID: self.topic.topicID!.uuidString)
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
                let api = NewCollect_Post.init(topicID: self.topic.topicID!.uuidString)
                api.call(async: true)
                DispatchQueue.main.async {
                    if api.code == .status_ok {
                        UIHelper.show(title: "收藏成功了")
                        self.topic.collectNum += 1
                    } else {
                        UIHelper.show(title: api.message)
                    }
                }
            } else if index == 2 {
                /// 添加评论
                DispatchQueue.main.async {
                    self.commentView.show()
                }
            } else {
                /// 评论列表
                let api = CommentList_Get.init(offset: 0, limit: 100, topicID: self.topicID)
                api.call(async: true)
                DispatchQueue.main.async {
                    if api.code == .status_ok {
                        self.commentListView.show()
                        self.commentListView.dataSource = api.dataSource
                        self.commentListView.reloadData()
                    } else {
                        
                    }
                }
            }
        }
    }
    
    func listCloseBtnEvent(index: Int) -> Void {
        commentListView.removeFromSuperview()
    }
    
    func commentEvent(index: Int) -> Void {
        
        if index == 1 {
            addComment(content: commentView.title)
        }
    }
    
    override func goNext() {
        /// 自定义分享界面
        self.shareView.show()
    }
    
    func umengShare(index: Int) -> Void {
        var type = UMSocialPlatformType.QQ
        if index == 0 {
            type = .QQ
        } else if index == 1 {
            type = .wechatSession
        } else {
            type = .sina
        }
        
        UmSDKHelper.sharedInstance.share(type: type, title: "标题", content: "分享到内容", vc: self) { (flag) in
            if flag {
                /// 分享成功
            } else {
                /// 分享失败
                UIHelper.show(title: "分享失败")
            }
        }
    }
}

