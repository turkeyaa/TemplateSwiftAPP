//
//  NewsVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/4/19.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class NewsVC: BasePageVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configTitles() -> [String] {
        return ["title","share","wiki","swift"]
    }
    
    override func configControlles() -> [UIViewController] {
        
        var controllers = [UIViewController]()
        let colors = [UIColor.red,UIColor.blue,UIColor.orange,UIColor.green]
        
        for index in 0..<configTitles().count {
            let vc = BaseVC()
            vc.view.backgroundColor = colors[index]
            controllers.append(vc)
        }
        return controllers
    }
}
