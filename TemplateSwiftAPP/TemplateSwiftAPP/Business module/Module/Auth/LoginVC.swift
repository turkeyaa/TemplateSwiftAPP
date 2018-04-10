//
//  Login.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class LoginVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "登录"
        self.rightTitle(title: "注册")
    }
    
    override func goNext() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
