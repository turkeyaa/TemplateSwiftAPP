//
//  UserListVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class UserListVC: BaseLoadTC {
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.rightTitle(title: "登录")
    }
    
    // MAKR: - 加载数据
    override func queryData() -> Array<Any> {
        
        let api = Users_Get.init()
        api.call(async: true)
        
        return api.dataSource!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UserCell = UserCell.tcell(tableView: tableView, reuse: true) as! UserCell
        
        let user = self.dataSource?[indexPath.row] as! User
        cell.showIndicator(flag: true)
        cell.updateUser(user: user)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        self.clickCell(index: indexPath.row)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserCell.classCellHeight()
    }
    
    // 点击 cell 事件
    func clickCell(index: Int) {
        let user = self.dataSource![index] as! User
        UIHelper.show(title: "Row:\(index) -- 姓名:\(user.name)")
    }
    
    // 进入登录
    override func goNext() {
        
        UIHelper.show(title: "点击登录")
        
        
        
        
//        let loginVc = LoginVC()
//        loginVc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(loginVc, animated: true)
    }
}