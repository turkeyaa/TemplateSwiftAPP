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
        
        let firstVc = MainVC()
        let secondVc = CategoryManageVC()
        let thirdVc = InformationVC()
        
        let firstNav = UINavigationController(rootViewController: firstVc)
        let secondNav = UINavigationController(rootViewController: secondVc)
        let thirdNav = UINavigationController(rootViewController: thirdVc)
        
        firstVc.tabBarItem = UITabBarItem.init(title: "主页", image: UIImage.init(named: "main"), selectedImage: UIImage.init(named: "mainSel"));
        firstVc.title = "主页"
        secondVc.tabBarItem = UITabBarItem.init(title: "分类", image: UIImage.init(named: "library"), selectedImage: UIImage.init(named: "librarySel"));
        secondVc.title = "分类"
        thirdVc.tabBarItem = UITabBarItem.init(title: "UI/Mudule", image: UIImage.init(named: "information"), selectedImage: UIImage.init(named: "informationSel"));
        thirdVc.title = "UI/Mudule";
        self.viewControllers = [firstNav,secondNav,thirdNav]
        
        // Do any additional setup after loading the view.
    }
}
