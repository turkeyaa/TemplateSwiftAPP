//
//  WebVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/4/12.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class WebVC: BaseWebVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 自定义HTML页面
        openURL = "https://github.com/turkeyaa.com"
    }
}
