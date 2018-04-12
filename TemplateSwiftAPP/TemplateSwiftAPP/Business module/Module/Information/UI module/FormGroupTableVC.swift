//
//  GroupFormTableVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/4/12.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class FormGroupTableVC: BaseFormGroupTC {
    
    lazy var iconCell: TCellImage = {
        let cell = TCellImage.tcell(tableView: self.tableView, reuse: true) as! TCellImage
        cell.icon = UIImage.init(named: "i_pay")
        cell.title = "图标"
        cell.value = "暂无"
        cell.valueColor = UIColor.red
        return cell
    }()
    lazy var iconCell2: TCellImage = {
        let cell = TCellImage.tcell(tableView: self.tableView, reuse: true) as! TCellImage
        cell.icon = UIImage.init(named: "i_about")
        cell.title = "关于"
        cell.value = "do it"
        cell.valueColor = UIColor.blue
        return cell
    }()
    lazy var labelCell: TCellLabel = {
        let cell = TCellLabel.tcell(tableView: self.tableView, reuse: true) as! TCellLabel
        cell.title = "标题"
        cell.value = "子标题"
        return cell
    }()
    lazy var switchCell: TCellNotify = {
        let cell = TCellNotify.tcell(tableView: self.tableView, reuse: true) as! TCellNotify
        cell.title = "通知"
        cell.showIndicator(flag: false)
        return cell
    }()
    lazy var accountCell: TCellInput = {
        let cell = TCellInput.tcell(tableView: self.tableView, reuse: true) as! TCellInput
        cell.title = "账号"
        cell.placeholder = "请输入账号"
        return cell
    }()
    lazy var passwordCell: TCellInput = {
        let cell = TCellInput.tcell(tableView: self.tableView, reuse: true) as! TCellInput
        cell.title = "密码"
        cell.placeholder = "请输入密码"
        return cell
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "分组表单元"
        
        groupCells = [[iconCell,iconCell2],[labelCell],[switchCell],[accountCell,passwordCell]]
    }
}
