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
        
        let loginVc = LoginVC()
        loginVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginVc, animated: true)
        
        
        /*
        /// 路径
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let fileName = NSStringFromClass(self.classForCoder) as String
        
        let savePath = filePath + "/" + fileName + ".plist"
        
        // 归档
        let dict = [
            "name":"yuwenhua",
            "phone":"18668089860"
        ]
        let info = User.init(dict: dict)
//        let info = User.init()
//        info.name = "yuwenhua"
//        info.phone = "18668089860"
//        info.name_spell = "ywh"
//        info.avatar_url = "icon.png"
//        info.user_id = "123456"

        let rs = NSKeyedArchiver.archiveRootObject(info, toFile: savePath);
        print("rs = \(rs)")
        
        // 解档
        let newInfo = NSKeyedUnarchiver.unarchiveObject(withFile: savePath) as! User;
        print("new : \(String(describing: newInfo.name))")
        */
    }
}
