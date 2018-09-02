//
//  TopicBottomView.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TopicBottomView: UIView {
    
    var clickItemBlock: BlockItem?
    
    /// 喜欢、收藏、评论
    lazy var likeBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setBackgroundImage(UIImage.init(named: "main_like"), for: .normal)
        view.setBackgroundImage(UIImage.init(named: "main_like"), for: .selected)
        view.addTarget(self, action: #selector(likeEvent), for: .touchUpInside)
        return view
    }()
    
    lazy var collectBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setBackgroundImage(UIImage.init(named: "main_collect"), for: .normal)
        view.setBackgroundImage(UIImage.init(named: "main_collect"), for: .selected)
        view.addTarget(self, action: #selector(collectEvent), for: .touchUpInside)
        return view
    }()
    
    lazy var commentBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setBackgroundImage(UIImage.init(named: "main_comment"), for: .normal)
        view.setBackgroundImage(UIImage.init(named: "main_comment"), for: .selected)
        view.addTarget(self, action: #selector(commentEvent), for: .touchUpInside)
        return view
    }()
    
    lazy var promptLabel: UILabel = {
        let view = UILabel.init()
        view.textColor = UIColor.lightGray
        view.textAlignment = .right
        return view
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.layer.borderColor = UIColor.init(white: 0.7, alpha: 0.3).cgColor
        self.layer.borderWidth = 0.5;
        self.backgroundColor = UIColor.white
        
        self.setupUI()
        self.setupLayout()
    }
    
    func setupUI() -> Void {
        self.addSubview(likeBtn)
        self.addSubview(collectBtn)
        self.addSubview(commentBtn)
        self.addSubview(promptLabel)
    }
    
    func setupLayout() -> Void {
        likeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(30)
            make.centerY.equalTo(self.snp.centerY)
        }
        collectBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(self.likeBtn.snp.right).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
        commentBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(self.collectBtn.snp.right).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        promptLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.right.equalTo(-30)
            make.width.equalTo(150)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    /// 更新
    func updateUI(topic: Topic) -> Void {
        self.promptLabel.text = "喜欢\(topic.likeNum) · 评论\(topic.replyNum)"
    }
    
    /// 事件
    @objc func likeEvent() -> Void {
        
        if clickItemBlock != nil {
            clickItemBlock!(0)
        }
    }
    @objc func collectEvent() -> Void {
        
        if clickItemBlock != nil {
            clickItemBlock!(1)
        }
    }
    @objc func commentEvent() -> Void {
        
        if clickItemBlock != nil {
            clickItemBlock!(2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
