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
    
    var groupCells = [[BaseTCell]]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var groupDataSource = [[Any]]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    /// MARK: 重写表视图样式
    override func tableViewStyle() -> UITableViewStyle {
        return UITableViewStyle.grouped
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (groupCells.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cells = groupCells[section]
        return cells.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = groupCells[indexPath.section]
        let cell = cells[indexPath.row]
        cell.selectionStyle = .blue
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.tableHeaderView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.tableFooterView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
