//
//  Register.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class RegisterVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "注册"
        self.leftIcon(icon: UIImage.init(named: "app_back")!)
        
        UIHelper.show(title: "todo - 暂未完成")
    }
}
