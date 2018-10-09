//
//  CategoryVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/20.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class CategoryManageVC: BasePageVC {
    override func viewDidLoad() {
        self.isHideNav = true
        super.viewDidLoad()
    }
    
    override func configTitles() -> [String] {
        return ["iOS","主题","分享","wiki","swift","vue","工具"]
    }
    
    override func configControlles() -> [UIViewController] {
        
        var controllers = [UIViewController]()
        for index in 0..<configTitles().count {
            let vc = CategoryDetailVC.init(categoryId: index+1)
            vc.parentNav = self.navigationController!
            controllers.append(vc)
        }
        return controllers
    }
}
