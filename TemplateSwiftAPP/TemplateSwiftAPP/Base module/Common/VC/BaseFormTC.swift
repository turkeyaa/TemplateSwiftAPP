//
//  BaseFormTC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class BaseFormTC: BaseTC {
    
    var cells = [BaseTCell]() {
        didSet {
            self.dataSource = cells
            self.tableView?.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cells[indexPath.row]
        cell.selectionStyle = .blue
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
