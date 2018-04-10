//
//  BaseFormGroupTC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class BaseFormGroupTC: BaseFormTC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataSource?.count)!
    }
    
}
