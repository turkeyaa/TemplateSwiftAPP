//
//  TopicNewVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TopicNewVC: BaseFormTC {
    
    lazy var textViewCell: TCellTextView = {
        let view = TCellTextView.tcell(tableView: self.tableView, reuse: true) as! TCellTextView
        return view
    }()
    lazy var categoryCell: TCellLabel = {
        let cell = TCellLabel.tcell(tableView: self.tableView, reuse: true) as! TCellLabel
        cell.title = "分类名称"
        cell.value = "主题"
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布新主题"
        self.leftTitle(title: "关闭")
        self.rightTitle(title: "保存")
        
        self.cells = [textViewCell,categoryCell]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.row].height()
    }
    
    override func goBack() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func goNext() {
        
        if textViewCell.title.count == 0 {
            UIHelper.show(title: "内容不能为空")
            return
        }
        
        DispatchQueue.global().async {
            
            let api = TopicNewApi.init(title: "iOS开发, 命名规范", content: self.textViewCell.title, categoryId: 1)
            api.call(async: true)
            DispatchQueue.main.async {
                if api.code == .status_ok {
                    UIHelper.show(title: "发布主题成功了")
                    self.navigationController?.dismiss(animated: true, completion: nil)
                } else {
                    UIHelper.show(title: api.message)
                }
            }
        }
        
    }
}


