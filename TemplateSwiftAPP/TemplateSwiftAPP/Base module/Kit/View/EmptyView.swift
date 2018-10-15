//
//  EmptyView.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

enum EmptyViewType {
    case EmptyViewType_Full
    case EmptyViewType_NoNav
    case EmptyViewType_NoTab
    case EmptyViewType_NoNavAndTab
    case EmptyViewType_Custom
}

class EmptyView: UIView {
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.image = settingPlaceholdImage()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = ColorMacro.ColorText999
        view.font = FontMacro.font14
        view.text = settingPlaceholdTitle()
        view.textAlignment = .center
        return view
    }()
    
    var emptyViewType = EmptyViewType.EmptyViewType_Full {
        willSet(newValue) {
            updateEmptyViewFrame(type: newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }
    
    func setupUI() -> Void {
        backgroundColor = UIColor.white
        addSubview(iconView)
        addSubview(titleLabel)
    }
    
    func setupLayout() -> Void {
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(300)
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.centerY.equalTo(self.snp.centerY).offset(0)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(30)
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
    }
    
    func updateLayout() -> Void {
        iconView.snp.remakeConstraints { (make) in
            make.width.height.equalTo(200)
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.centerY.equalTo(self.snp.centerY).offset(0)
        }
        titleLabel.snp.remakeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(30)
            make.top.equalTo(iconView.snp.bottom).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateEmptyViewFrame(type: EmptyViewType) -> Void {
        if type == .EmptyViewType_Full {
            self.frame = CGRect.init(x: 0, y: 0, width: Device_width, height: Device_height)
        } else if type == .EmptyViewType_NoNav {
            self.frame = CGRect.init(x: 0, y: Device_nav+Device_status, width: Device_width, height: Device_height-Device_nav-Device_status)
        } else if type == .EmptyViewType_NoTab {
            self.frame = CGRect.init(x: 0, y: 0, width: Device_width, height: Device_height-Device_tab)
        } else if type == .EmptyViewType_NoNavAndTab {
            self.frame = CGRect.init(x: 0, y: Device_nav+Device_status, width: Device_width, height: Device_height-Device_nav-Device_status-Device_tab)
        } else {
            /// 自定义尺寸
        }
        
        /// 更新约束
        updateLayout()
    }
    
    /// Subclassing
    func settingPlaceholdImage() -> UIImage {
//        return UIImage.init(named: "app_network_error")!
        return UIImage.init(named: "app_empty")!
    }
    
    func settingPlaceholdTitle() -> String {
        return "点击重新加载"
    }
    
    func customEmptyViewFrame(frame: CGRect) -> Void {
        self.frame = frame
    }
}
