//
//  BasePageVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/12.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
import DNSPageView

class BasePageVC: BaseVC {
    
//    private var titles = [String]()
//    private var controllers = [UIViewController]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfig()
    }
    
    func setupConfig() -> Void {
        
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isTitleScaleEnabled = true
        style.titleSelectedColor = .orange
        
        // 设置标题内容
        let titles = configTitles()
        
        // 创建每一页对应的controller
        let childViewControllers: [UIViewController] = configControlles()
        
        let size = UIScreen.main.bounds.size
        
        // 创建对应的DNSPageView，并设置它的frame
        // titleView和contentView会连在一起
        var paddingX: CGFloat = 0
        if self.isHideNav {
            paddingX += 20
        } else {
            paddingX += Device_nav+Device_status
        }
        if DeviceUtil.is_iPhoneX() {
            paddingX += 44
        }
        
        let pageView = DNSPageView(frame: CGRect(x: 0, y: paddingX, width: size.width, height: size.height), style: style, titles: titles, childViewControllers: childViewControllers)
        view.addSubview(pageView)
    }
    
    func configTitles() -> [String] {
        return [String]()
    }
    
    func configControlles() -> [UIViewController] {
        return [UIViewController]()
    }
}
