//
//  EmptyVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/4/19.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class EmptyVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rightTitle(title: "刷新")
        
        self.isShowEmptyView = false
    }
    
    override func goNext() {
        self.isShowEmptyView = !self.isShowEmptyView
    }
}
