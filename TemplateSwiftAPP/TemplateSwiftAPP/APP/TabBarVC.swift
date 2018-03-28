//
//  TabBarVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let first = MainVC()
        let second = UserListVC()
        
        let firstNav = UINavigationController.init(rootViewController: first)
        let secondNav = UINavigationController.init(rootViewController: second)
        
        first.tabBarItem = UITabBarItem.init(title: "主页", image: UIImage.init(named: "main"), selectedImage: UIImage.init(named: "mainSel"));
        first.title = "主页";
        second.tabBarItem = UITabBarItem.init(title: "用户", image: UIImage.init(named: "library"), selectedImage: UIImage.init(named: "librarySel"));
        second.title = "用户";
        
        self.viewControllers = [firstNav,secondNav]
        
        // Do any additional setup after loading the view.
    }
}
