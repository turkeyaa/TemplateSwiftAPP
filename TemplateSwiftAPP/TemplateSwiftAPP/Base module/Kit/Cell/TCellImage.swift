//
//  TCellImage.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TCellImage: BaseTCell {
    /// 属性
    var icon: UIImage? = nil {
        didSet {
            iconView.image = icon
        }
    }
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var value: String = "" {
        didSet {
            valueLabel.text = value
        }
    }
    
    var titleColor: UIColor = .gray {
        didSet {
            self.titleLabel.textColor = titleColor
        }
    }
    var valueColor: UIColor = .darkText {
        didSet {
            self.valueLabel.textColor = valueColor
        }
    }
    
    /// 懒加载 - 私有成员变量
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = titleColor
        return view
    }()
    
    private lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.textColor = valueColor
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override func setupSubViews() {
        
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        setupLayouts()
    }
    
    override func setupLayouts() {
        
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(10)
            make.centerY.equalTo(self.snp.centerY)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(70)
        }
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(-30)
            make.left.equalTo(titleLabel.snp.right).offset(10)
        }
    }
    
    override class func classCellHeight() -> CGFloat {
        return 50.0
    }
    
    override func height() -> CGFloat {
        return TCellImage.classCellHeight()
    }
}
