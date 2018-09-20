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
        let second = CategoryVC()
        let third = InformationVC()
        
        let firstNav = UINavigationController.init(rootViewController: first)
//        let secondNav = UINavigationController.init(rootViewController: second)
        let thirdNav = UINavigationController.init(rootViewController: third)
        
        first.tabBarItem = UITabBarItem.init(title: "主页", image: UIImage.init(named: "main"), selectedImage: UIImage.init(named: "mainSel"));
        first.title = "主页";
        second.tabBarItem = UITabBarItem.init(title: "分类", image: UIImage.init(named: "library"), selectedImage: UIImage.init(named: "librarySel"));
        second.title = "分类";
        third.tabBarItem = UITabBarItem.init(title: "UI/Mudule", image: UIImage.init(named: "information"), selectedImage: UIImage.init(named: "informationSel"));
        third.title = "UI/Mudule";
        
        self.viewControllers = [firstNav,second,thirdNav]
        
        // Do any additional setup after loading the view.
    }
}
