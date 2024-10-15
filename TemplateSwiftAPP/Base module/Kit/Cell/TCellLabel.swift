//
//  TCellLabel.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TCellLabel: BaseTCell {
    
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
    
    /// lazy loading - private variable
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
    
    override func setupSubViews() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        setupLayouts()
    }
    
    override func setupLayouts() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(50)
            make.width.equalTo(70)
        }
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(-30)
            make.left.equalTo(titleLabel.snp.right).offset(10)
        }
    }
    
    override func height() -> CGFloat {
        return TCellLabel.classCellHeight()
    }
    
    override class func classCellHeight() -> CGFloat {
        return 50.0
    }
}
