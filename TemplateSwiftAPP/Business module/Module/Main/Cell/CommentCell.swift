//
//  CommentCell.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: BaseTCell {
    
    lazy var iconView: UIImageView = {
        let view = UIImageView()
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
    
    override func setupSubViews() {
        
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        self.addSubview(lineView)
        self.addSubview(timeLabel)
        self.addSubview(contentLabel)
        
        self.setupLayouts()
    }
    
    override func setupLayouts() {
        
        iconView.snp.makeConstraints({ (make) -> Void in
            make.width.height.equalTo(20)
            make.left.equalTo(20)
            make.top.equalTo(5)
        })
        titleLabel.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.top.equalTo(5)
        })
        timeLabel.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.right.equalTo(-20)
            make.height.equalTo(20)
            make.top.equalTo(5)
        })
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(iconView.snp.bottom).offset(5)
            make.height.equalTo(1)
        }
        contentLabel.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo(20)
            make.right.equalTo(-10)
            make.top.equalTo(iconView.snp.bottom).offset(5)
            make.bottom.equalTo(5)
        })
    }
    
    func updateComment(comment: Comment) -> Void {
        iconView.image = UIImage.init(named: "app_placeholder")
        titleLabel.text = comment.author
        timeLabel.text = "post time:" + DateUtil.timeStampToString(timeStamp: comment.createTime)
        contentLabel.text = comment.content
    }
    
    override class func classCellHeight() -> CGFloat {
        return 80.0
    }
    
}
