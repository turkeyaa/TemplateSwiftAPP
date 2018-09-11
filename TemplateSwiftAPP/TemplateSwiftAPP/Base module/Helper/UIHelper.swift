//
//  UIHelper.swift
//  TemplateSwift
//
//  Created by yuwenhua on 2017/10/8.
//  Copyright © 2017年 DS. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

let contentHeight: CGFloat = 55.0

class UIHelper: UIView {
    
    static let instance = UIHelper()
    var centerY: CGFloat = 0.0
    var titleWidth: CGFloat = 0.0
    
    lazy var contentView: UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColor.init(white: 0.1, alpha: 0.9)
        view.alpha = 0.0
        view.layer.cornerRadius = 10.0
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        var label = UILabel.init()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.alpha = 0.0
        return label
    }()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        let window = UIApplication.shared.keyWindow!
        window.addSubview(contentView)
        window.addSubview(titleLabel)
        
        centerY = window.frame.height/2.0
        setupLayout()
    }
    
    private func setupLayout() {
        
        contentView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(contentHeight)
            make.centerY.equalTo(centerY-contentHeight/2)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(contentHeight)
            make.top.equalTo(self.contentView.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func postMessage(message: String) -> Void {
        if message.count > 0 {
            titleLabel.alpha = 1.0
            contentView.alpha = 1.0
            titleLabel.text = message
            
            postSetting()
        }
    }
    
    func postSetting() -> Void {
        let delayTime: DispatchTimeInterval = .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayTime) {
            self.titleLabel.alpha = 0.0;
            self.contentView.alpha = 0.0;
        }
    }
    
    /**
     *  自定义 toast
     *  @param title        内容
     */
    static func show(title: String) {
        UIHelper.instance.postMessage(message: title)
    }
    
}
