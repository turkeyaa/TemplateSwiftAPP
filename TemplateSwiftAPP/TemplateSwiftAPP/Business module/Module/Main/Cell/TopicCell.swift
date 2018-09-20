//
//  TopicCell.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/8/29.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import Kingfisher

class TopicCell: BaseTCell {
    
    /// 懒加载
    lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 2.0
        return view
    }()
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.7, alpha: 0.3)
        return view
    }()
    lazy var contentLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.numberOfLines = 2
        return view
    }()
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor.lightGray
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = NSTextAlignment.left
        return view
    }()
    
    override class func classCellHeight() -> CGFloat {
        return 100.0
    }
    
    override func setupSubViews() {
        
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        self.addSubview(lineView)
        self.addSubview(timeLabel)
        self.addSubview(contentLabel)
        
        self.setupLayouts()
    }
    
    override func setupLayouts() {
        
        iconView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(20)
            make.left.equalTo(20)
            make.top.equalTo(5)
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.greaterThanOrEqualTo(40)
            make.height.equalTo(20)
            make.top.equalTo(5)
        }
        timeLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.height.equalTo(20)
            make.top.equalTo(5)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(iconView.snp.bottom).offset(5)
            make.height.equalTo(1)
        }
        contentLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(10)
            make.right.equalTo(-20)
            make.top.equalTo(iconView.snp.bottom).offset(5)
            make.bottom.equalTo(5)
        }
        
    }
    
    func updateTopic(topic: Topic) -> Void {
        titleLabel.text = topic.author
        timeLabel.text = "发布于:" + DateUtil.timeStampToString(timeStamp: topic.createTime)
        contentLabel.text = topic.content
        let url = URL.init(string: URLHelper.sharedInstance.restImageURL() + topic.authorImage)
        iconView.kf.setImage(with: url, placeholder: UIImage.init(named: "app_placeholder"), options: nil, progressBlock: { (receivedSize, totalSize) in
            let progress = Float(receivedSize) / Float(totalSize)
            SVProgressHUD.showProgress(progress)
            SVProgressHUD.setBackgroundColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5))
            SVProgressHUD.setForegroundColor(UIColor.white)
        }, completionHandler: { (image, error, cacheType, url) in
            SVProgressHUD.dismiss()
        })
    }
}
