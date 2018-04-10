//
//  Information.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/4/10.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class InformationVC: BaseFormTC {
    
    lazy var iconCell: TCellImage = {
        let cell = TCellImage.tcell(tableView: self.tableView, reuse: true) as! TCellImage
        cell.icon = UIImage.init(named: "i_pay")
        cell.title = "图标cell"
        cell.value = "暂无"
        cell.valueColor = UIColor.red
        return cell
    }()
    lazy var labelCell: TCellLabel = {
        let cell = TCellLabel.tcell(tableView: self.tableView, reuse: true) as! TCellLabel
        cell.title = "标题cell"
        cell.value = "子标题"
        return cell
    }()
    lazy var switchCell: TCellNotify = {
        let cell = TCellNotify.tcell(tableView: self.tableView, reuse: true) as! TCellNotify
        cell.title = "通知cell"
        return cell
    }()
    lazy var textFieldCell: TCellInput = {
        let cell = TCellInput.tcell(tableView: self.tableView, reuse: true) as! TCellInput
        cell.title = "输入cell"
        cell.placeholder = "请输入账号"
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 自定义表单元
        self.cells = [iconCell,labelCell,switchCell,textFieldCell]
    }
    
    func switchEvent(switch: UISwitch) {
        
    }
    
}
