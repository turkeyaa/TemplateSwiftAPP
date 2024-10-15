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
    
    var titleBgColor: UIColor = .white {
        didSet {
            titleButton.backgroundColor = titleBgColor
        }
    }
    
    var titleColor: UIColor = .gray {
        didSet {
            titleButton.setTitleColor(titleColor, for: .normal)
        }
    }
    
    /// lazy loading - private variable
    private lazy var titleButton: UIButton = {
        let view = UIButton.init(type: .custom)
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override func setupSubViews() {
        contentView.addSubview(titleButton)
        setupLayouts()
    }
    
    override func setupLayouts() {
        
        titleButton.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.equalTo(0)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
    }
    
    override func height() -> CGFloat {
        return TCellButton.classCellHeight()
    }
    
    override class func classCellHeight() -> CGFloat {
        return 70.0
    }
    
    func addButtonTarget(target: Any, selector: Selector) -> Void {
        titleButton.addTarget(target, action: selector, for: .touchUpInside)
    }
}
