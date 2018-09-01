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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = topic.title
        self.rightIcon(icon: UIImage.init(named: "app_share")!)
        
        /// 初始化
        let md = MarkdownView()
        self.view.addSubview(md)
        
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
            make.top.left.right.bottom.equalTo(0)
        }
        
    }
    
    override func goNext() {
        /*
        let shareView = ShareView.init(titles: ["QQ","微信","新浪微博"], images: [UIImage.init(named: "app_share")!,UIImage.init(named: "app_share")!,UIImage.init(named: "app_share")!]
            )
        self.view.addSubview(shareView)
 */
        
    }
    
}
