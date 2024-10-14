//
//  FormTableVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/4/12.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class FormTableVC: BaseFormTC {
    
    lazy var iconCell: TCellImage = {
        let cell = TCellImage.tcell(tableView: self.tableView, reuse: true) as! TCellImage
        cell.icon = UIImage.init(named: "i_pay")
        cell.title = "first title"
        cell.value = "second title"
        cell.valueColor = UIColor.red
        return cell
    }()
    lazy var labelCell: TCellLabel = {
        let cell = TCellLabel.tcell(tableView: self.tableView, reuse: true) as! TCellLabel
        cell.title = "first title"
        cell.value = "second title"
        return cell
    }()
    lazy var switchCell: TCellNotify = {
        let cell = TCellNotify.tcell(tableView: self.tableView, reuse: true) as! TCellNotify
        cell.title = "notification title"
        cell.showIndicator(flag: false)
        cell.addSwitchTarget(target: self, selector: #selector(switchEvent))
        return cell
    }()
    lazy var textFieldCell: TCellInput = {
        let cell = TCellInput.tcell(tableView: self.tableView, reuse: true) as! TCellInput
        cell.title = "account"
        cell.placeholder = "input an email"
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "cell"
        /// 自定义表单元
        self.cells = [iconCell,labelCell,switchCell,textFieldCell]
        tableView.tableHeaderView = UIView.init(frame: .init(x: 0, y: 0, width: Device_width, height: 10))
    }
    
    @objc func switchEvent(sender: UISwitch) -> Void {
        if sender.isOn {
            UIHelper.show(title: "open")
        } else {
            UIHelper.show(title: "close")
        }
    }
}
