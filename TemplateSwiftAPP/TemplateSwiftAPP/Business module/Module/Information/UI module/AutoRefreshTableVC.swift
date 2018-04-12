//
//  AutoRefreshTableVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/4/12.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class AutoRefreshTableVC: BaseLoadTC {
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    // MAKR: - 加载数据
    override func queryData() -> Array<Any> {
        
        let api = Users_Get.init()
        api.call(async: true)
        
        if api.code == .RestApi_OK {
            self.dataSource = api.dataSource
        }
        return self.dataSource!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UserCell = UserCell.tcell(tableView: tableView, reuse: true) as! UserCell
        
        let user = self.dataSource?[indexPath.row] as! User
        cell.showIndicator(flag: true)
        cell.updateUser(user: user)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserCell.classCellHeight()
    }
}
