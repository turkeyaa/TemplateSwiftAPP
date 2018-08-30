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
        return view
    }()
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
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
        view.textAlignment = NSTextAlignment.right
        return view
    }()
    
    override class func classCellHeight() -> CGFloat {
        return 100.0
    }
    
    override func setupSubViews() {
        
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(timeLabel)
        
        self.setupLayouts()
    }
    
    override func setupLayouts() {
        
        iconView.snp.makeConstraints({ (make) -> Void in
            make.width.height.equalTo(60)
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(10)
        })
        titleLabel.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.right.equalTo(-10)
            make.height.equalTo(30)
            make.top.equalTo(10)
        })
        contentLabel.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.right.equalTo(-20)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(-5)
        })
        timeLabel.snp.makeConstraints({ (make) -> Void in
            make.right.equalTo(-20)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.top.equalTo(10)
        })
    }
    
    func updateTopic(topic: Topic) -> Void {
        titleLabel.text = topic.title
        contentLabel.text = topic.content
        timeLabel.text = String.timeStampToString(timeStamp: topic.createTime)
        iconView.image = UIImage.init(named: "app_placeholder")
//        let url = URL.init(string: "")
//        iconView!.kf.setImage(with: url, placeholder: UIImage.init(named: "app_placeholder"), options: nil, progressBlock: { (receivedSize, totalSize) in
//            let progress = Float(receivedSize) / Float(totalSize)
//            SVProgressHUD.showProgress(progress)
//            SVProgressHUD.setBackgroundColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5))
//            SVProgressHUD.setForegroundColor(UIColor.white)
//        }, completionHandler: { (image, error, cacheType, url) in
//            SVProgressHUD.dismiss()
//        })
    }
}
