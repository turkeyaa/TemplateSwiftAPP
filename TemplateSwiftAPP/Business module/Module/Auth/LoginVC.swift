//
//  Login.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
//import SnapKit

class LoginVC: BaseFormTC {
    
    var user = User()
    
    lazy var accountCell: TCellInput = {
        let cell = TCellInput.tcell(tableView: self.tableView, reuse: true) as! TCellInput
        cell.icon = UIImage.init(named: "account")
        cell.title = "account"
        cell.placeholder = "input an account"
        cell.showIndicator(flag: false)
        return cell
    }()
    lazy var passwordCell: TCellInput = {
        let cell = TCellInput.passwordInputCell() as! TCellInput
        cell.icon = UIImage.init(named: "password")
        cell.title = "password"
        cell.placeholder = "input a password"
        cell.showIndicator(flag: false)
        return cell
    }()
    
    lazy var loginBtn2: TCellButton = {
        let cell = TCellButton.tcell(tableView: self.tableView, reuse: true) as! TCellButton
        cell.title = "login"
        cell.titleColor = UIColor.white
        cell.titleBgColor = UIColor.red
        cell.showIndicator(flag: false)
        cell.addButtonTarget(target: self, selector: #selector(loginEvent))
        return cell
    }()
    
    lazy var thirdLoginView: ThirdLoginView = {
        let titles = ["Google","Facebook"]
        let icons = [UIImage.init(named: "app_google")!,UIImage.init(named: "app_facebook")!]
        
        let view = ThirdLoginView.init(frame: CGRect.init(x: 0, y: self.view.frame.size.height-300, width: Device_width, height: 200), titles: titles, images: icons)
        view.clickItemBlock = {
            (index: Int) -> Void in
            UIHelper.show(title: "login to \(titles[index])")
            self.umengLogin(index: index)
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "login"
        self.rightTitle(title: "register")
        
        tableView.separatorInset = UIEdgeInsets.init()
        tableView.separatorColor = UIColor.clear
        
        tableView.tableHeaderView = UIView.init(frame: .init(x: 0, y: 0, width: Device_width, height: 60))
        cells = [accountCell,passwordCell,loginBtn2]
        
        tableView.addSubview(thirdLoginView)
    }
    
    override func goNext() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // custom third login logic
    func umengLogin(index: Int) -> Void {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.row].height()
    }
    
    @objc func loginEvent() -> Void {
        
        let account = accountCell.value
        let password = passwordCell.value
        
        if account.count != 11 {
            showInfoMessage(hud: "Please input correct phone number")
            return
        }
        if password.count < 6 {
            showInfoMessage(hud: "Password must contain more than 6 characters")
            return
        }
        
        if RegularUtil.isPhoneNumber(phone: account) == false {
            showInfoMessage(hud: "Please input correct phone number")
            return
        }
        
        GCDUtil.runInGlobalQueue {
            self.showLoadingHUD()
            let loginApi = Login_Post.init(account: account, password: password)
            loginApi.call(async: false)
            
            var userApi: UserInfo_Post?
            if loginApi.code == .status_ok {
                userApi = UserInfo_Post.init(token: loginApi.token)
                userApi!.call(async: false)
            }
            
            GCDUtil.runInMainQueue {
                self.hideLoadingHUD()
                /// 进入主线程,更新界面
                if loginApi.code == .status_ok && userApi!.code == .status_ok {
                    
                    self.showSuccessMessage(hud: HUD_success)
                    
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
