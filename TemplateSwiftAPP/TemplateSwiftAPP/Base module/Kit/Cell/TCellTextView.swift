//
//  TCellTextView.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TCellTextView: BaseTCell {
    
    var title: String = "" {
        didSet {
            textView.text = title
        }
    }
    
    /// 懒加载 - 私有成员变量
    lazy var textView: UITextView = {
        let view = UITextView.init()
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
    
    override func setupSubViews() {
        
        addSubview(textView)
        setupLayouts()
    }
    
    override func setupLayouts() {
        
        textView.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.right.bottom.equalTo(-10)
        }
    }
    
    override func height() -> CGFloat {
        return TCellTextView.classCellHeight()
    }
    
    override class func classCellHeight() -> CGFloat {
        return 200.0
    }
}
