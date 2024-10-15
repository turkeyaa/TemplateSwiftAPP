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

class TopicDetailVC: BaseMarkdownVC {
    
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
        let titles = ["Facebook","Youtube","X","other"]
        let icons = [UIImage.init(named: "app_facebook")!,UIImage.init(named: "app_google")!,UIImage.init(named: "app_x")!,UIImage.init(named: "app_other")!]
        let view = ShareView.init(titles: titles, images:icons)
        view.clickItemBlock = {
            (index: Int) -> Void in
            UIHelper.show(title: "share to \(titles[index])")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        super.mdFileName = "sample"
        
        self.rightIcon(icon: UIImage.init(named: "app_share")!)
        
//        bottomView.snp.makeConstraints { (make) in
//            make.left.bottom.right.equalTo(0)
//            make.height.equalTo(50)
//        }
        
        self.loadTopic()
    }
    
    /// api
    func loadTopic() -> Void {
        
        self.showLoadingHUD(hud: HUD_loading)
        
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
                    super.mdFile = self.topic.content
//                    self.bottomView.updateUI(topic: self.topic)
                } else {
                    
                }
            }
        }
    }
    
    func addComment(content: String) -> Void {
        
        self.showLoadingHUD(hud: HUD_loading)
        
        DispatchQueue.global().async {
            
            let api = NewComment_Post.init(topicID: self.topicID, content: content)
            api.call(async: true)
            
            DispatchQueue.main.async {
                self.hideLoadingHUD()
                if api.code == .status_ok {
                    UIHelper.show(title: HUD_success)
                } else {
                    UIHelper.show(title: api.message)
                }
            }
        }
    }
    
    /// 交互事件
    func btnEvent(index: Int) -> Void {
        
        if !WorkSpace.sharedInstance.appPreference.isLoginSuccess {
            UIHelper.show(title: "not login")
            return
        }
        
        DispatchQueue.global().async {
            
            if index == 0 {
                let api = NewLike_Post.init(topicID: self.topic.topicID!.uuidString)
                api.call(async: true)
                DispatchQueue.main.async {
                    if api.code == .status_ok {
                        UIHelper.show(title: HUD_success)
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
                        UIHelper.show(title: HUD_success)
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
        self.shareView.show()
    }
    
    func umengShare(index: Int) -> Void {
        // custom share logic
    }
}

