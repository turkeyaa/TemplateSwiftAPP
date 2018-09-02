//
//  Login.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class LoginVC: BaseFormTC {
    
    var user = User()
    
    lazy var accountCell: TCellInput = {
        let cell = TCellInput.tcell(tableView: self.tableView, reuse: true) as! TCellInput
        cell.icon = UIImage.init(named: "account")
        cell.title = "账号"
        cell.placeholder = "请输入账号"
        cell.value = "18698894171"
        cell.showIndicator(flag: false)
        return cell
    }()
    lazy var passwordCell: TCellInput = {
        let cell = TCellInput.passwordInputCell() as! TCellInput
        cell.icon = UIImage.init(named: "password")
        cell.title = "密码"
        cell.placeholder = "请输入密码"
        cell.value = "tourist"
        cell.showIndicator(flag: false)
        return cell
    }()
    
    lazy var loginBtn2: TCellButton = {
        let cell = TCellButton.tcell(tableView: self.tableView, reuse: true) as! TCellButton
        cell.title = "登录"
        cell.titleColor = UIColor.white
        cell.titleBgColor = UIColor.red
        cell.showIndicator(flag: false)
        cell.addButtonTarget(target: self, selector: #selector(loginEvent))
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "登录"
        self.rightTitle(title: "注册")
        self.leftIcon(icon: UIImage.init(named: "app_back")!)
        
        
        /// 分割线
        tableView!.separatorInset = UIEdgeInsets.init()
        tableView!.separatorColor = UIColor.clear
        
        tableView!.tableHeaderView = UIView.init(frame: .init(x: 0, y: 0, width: Device_width, height: 60))
        cells = [accountCell,passwordCell,loginBtn2]
    }
    
    override func goNext() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.row].height()
    }
    
    @objc func loginEvent() -> Void {
        
        let account = accountCell.value
        let password = passwordCell.value
        
        if account.count < 6 {
            showInfoMessage(hud: "账号不能小于6位数")
            return
        }
        if password.count < 6 {
            showInfoMessage(hud: "密码不能小于6位数")
            return
        }
        
        DispatchQueue.global().async {
            self.showLoadingHUD(hud: "登录中...")
            
            sleep(1)
            
            let loginApi = Login_Post.init(account: account, password: password)
            loginApi.call(async: false)
            
            var userApi: UserInfo_Post?
            if loginApi.code == RestApiCode.RestApi_OK {
                userApi = UserInfo_Post.init(token: loginApi.token)
                userApi!.call(async: false)
            }
            
            DispatchQueue.main.async {
                /// 进入主线程,更新界面
                if loginApi.code == .RestApi_OK && userApi!.code == .RestApi_OK {
                    
                    self.showSuccessMessage(hud: "登录成功")
                    
                    WorkSpace.sharedInstance.onLogIn(api: userApi!, account: account, password: password)
                    
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    self.showErrorMessage(hud: loginApi.message)
                }
            }
        }
    }
}
