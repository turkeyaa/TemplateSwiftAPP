//
//  CategoryVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/20.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class CategoryVC: BasePageVC {
    override func viewDidLoad() {
        self.isHideNav = true
        super.viewDidLoad()
    }
    
    override func configTitles() -> [String] {
        return ["主题","分享","wiki","swift"]
    }
    
    override func configControlles() -> [UIViewController] {
        
        let colors = [UIColor.red,UIColor.blue,UIColor.orange,UIColor.green]
        
        var controllers = [UIViewController]()
        for index in 0..<configTitles().count {
            let vc = BaseVC()
            vc.view.backgroundColor = colors[index]
            controllers.append(vc)
        }
        return controllers
    }
}
