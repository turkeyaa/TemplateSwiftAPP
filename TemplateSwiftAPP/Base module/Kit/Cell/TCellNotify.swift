//
//  TCellNotify.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TCellNotify: BaseTCell {
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var titleColor: UIColor = .gray {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    var isNotifyOpened: Bool = true {
        didSet {
            switchView.isOn = isNotifyOpened
        }
    }
    
    /// lazy loading - private variable
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = titleColor
        return view
    }()
    
    private lazy var switchView: UISwitch = {
        let view = UISwitch.init()
        return view
    }()
    
    override func setupSubViews() {
        
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(switchView)
        
        setupLayouts()
    }
    
    override func setupLayouts() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(50)
            make.width.equalTo(70)
        }
        switchView.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.width.equalTo(60)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    func addSwitchTarget(target: Any?, selector: Selector) -> Void {
        switchView.addTarget(target, action: selector, for: .valueChanged)
    }
    
    override func height() -> CGFloat {
        return TCellNotify.classCellHeight()
    }
    
    override class func classCellHeight() -> CGFloat {
        return 50.0
    }
}
