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
        
        self.rightTitle(title: "reset")
        
        self.isShowEmptyView = true
    }
    
    override func goNext() {
        self.isShowEmptyView = true
    }
    
    override func emptyTapGesture() {
        UIHelper.show(title: HUD_success)
        self.isShowEmptyView = !self.isShowEmptyView;
    }
}
