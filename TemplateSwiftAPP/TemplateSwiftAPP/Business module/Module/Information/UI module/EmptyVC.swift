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
        
        self.rightTitle(title: "重置")
        
        self.isShowEmptyView = true
    }
    
    override func goNext() {
        self.isShowEmptyView = true
    }
    
    override func emptyTapGesture() {
        UIHelper.show(title: "刷新完成")
        self.isShowEmptyView = !self.isShowEmptyView;
    }
}
