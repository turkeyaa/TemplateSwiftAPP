//
//  BasePageVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/12.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
import PageController

/// todo - 待优化
class BasePageVC: PageController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBar.backgroundColor = UIColor.white
//        menuBar.isAutoSelectDidEndUserInteractionEnabled = false
        
        viewControllers = addSubControllers()
    }
    
//    override var frameForMenuBar: CGRect {
//        let frame = super.frameForMenuBar
//        
//        return CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: 60)
//    }
    
    func addSubControllers() -> [UIViewController] {
        
        let names = [
            "favorites",
            "recents",
            "contacts",
            "history",
            "more",
            ]
        
        return names.map { name -> UIViewController in
            let viewController = BaseVC()
            viewController.title = name
            return viewController
        }
    }
}
