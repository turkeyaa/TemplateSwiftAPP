//
//  TCellButton.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TCellButton: BaseTCell {
    
    var title: String = "" {
        didSet {
            titleButton.setTitle(title, for: .normal)
        }
    }
    
    var titleColor: UIColor = .gray {
        didSet {
            titleButton.setTitleColor(titleColor, for: .normal)
        }
    }
    
    /// 懒加载 - 私有成员变量
    lazy var titleButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override func setupSubViews() {
        
        addSubview(titleButton)
        setupLayouts()
    }
    
    override func setupLayouts() {
        
        titleButton.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
    }
    
    override class func classCellHeight() -> CGFloat {
        return 60.0
    }
    
    
}
