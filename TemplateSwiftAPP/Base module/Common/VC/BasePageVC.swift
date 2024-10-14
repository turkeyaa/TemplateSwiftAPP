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
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfig()
    }
    
    func setupConfig() -> Void {
        
        // create DNSPageStyle and set a style
        let style = PageStyle()
        style.isTitleScaleEnabled = true
        style.titleSelectedColor = .orange
        
        let titles = configTitles()
        
        // create some sub controllers
        let childViewControllers: [UIViewController] = configControlles()
        
        let size = UIScreen.main.bounds.size
        
        // create PageView，set frame
        var paddingX: CGFloat = 0
        if self.isHideNav {
            paddingX += Device_status
        } else {
            paddingX += Device_nav+Device_status
        }
        
        // todo occording to device type
        if DeviceUtil.is_iPhoneX() {
            paddingX += 44
        }
        else {
            paddingX += 44
        }
        
        let pageView = PageView(frame: CGRect(x: 0, y: paddingX, width: size.width, height: size.height-paddingX), style: style, titles: titles, childViewControllers: childViewControllers)
        view.addSubview(pageView)
    }
    
    func configTitles() -> [String] {
        return [String]()
    }
    
    func configControlles() -> [UIViewController] {
        return [UIViewController]()
    }
}
