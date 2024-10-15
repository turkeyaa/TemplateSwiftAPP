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
        view.placeholder = "post a topic..."
        view.showIndicator(flag: false)
        view.beginInput()
        return view
    }()
    lazy var categoryCell: TCellLabel = {
        let cell = TCellLabel.tcell(tableView: self.tableView, reuse: true) as! TCellLabel
        cell.title = "category"
        cell.value = "Swift"
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New topic"
        self.leftTitle(title: "close")
        self.rightTitle(title: "save")
        
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
            UIHelper.show(title: "no contents")
            return
        }
        
        GCDUtil.runInGlobalQueue {
            let api = TopicNew_Post.init(title: "Swift code basic", content: self.textViewCell.title, categoryId: 1)
            api.call(async: true)
            GCDUtil.runInMainQueue {
                if api.code == .status_ok {
                    UIHelper.show(title: "post a topic successfully")
                    self.navigationController?.dismiss(animated: true, completion: nil)
                } else {
                    UIHelper.show(title: api.message)
                }
            }
        }
    }
}


