//
//  UserInfoVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class UserInfoVC: BaseFormGroupTC {
    
    var groupValueDataSource = [[]]
    
    lazy var exitBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.frame = CGRect.init(x: 30, y: 400, width: Device_width-60, height: 45)
        view.setTitle("退出", for: .normal)
        view.addTarget(self, action: #selector(logoutEvent), for: .touchUpInside)
        view.backgroundColor = UIColor.red
        return view
    }()
    
    lazy var userHeaderView: UserInfoHeaderView = {
        let view = UserInfoHeaderView.init(frame: CGRect.init(x: 0, y: 10, width: Device_width, height: 100))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "用户信息"
        groupDataSource = [["昵称","加入时间","地区"],["主页","签名"]]
        self.rightTitle(title: "我发布的")
        
        let user = WorkSpace.sharedInstance.user
        groupValueDataSource = [[user.nickName,String.timeStampToString(timeStamp: user.createTime),user.city],[user.website,user.sign]]
        
        tableView.addSubview(exitBtn)
        tableView.addSubview(userHeaderView)
        
        userHeaderView.updateUI(user: user)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupDataSource.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let titles = groupDataSource[section]
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UICell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .value2, reuseIdentifier: cellIdentifier)
        }
        
        let titles = groupDataSource[indexPath.section]
        let title = titles[indexPath.row] as! String
        
        let values = groupValueDataSource[indexPath.section]
        let value = values[indexPath.row] as! String
        
        cell?.textLabel?.text = title
        cell?.detailTextLabel?.text = value
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 70.0
        }
        return 10.0
    }
    
    @objc func logoutEvent() -> Void {
        WorkSpace.sharedInstance.onLogOut()
        UIHelper.show(title: "退出登录成功")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func goNext() {
        let vc = UserCollect()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
