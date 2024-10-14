//
//  MainVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class MainVC: BaseLoadTC {
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.rightTitle(title: "Login")
        self.leftTitle(title: "Create")
        LoginNotify.sharedInstance.addLoginObserver(target: self, selector: #selector(loginSuccess))
        LoginNotify.sharedInstance.addLogoutObserver(target: self, selector: #selector(logoutSuccess))
        
        self.emptyView.emptyViewType = EmptyViewType.EmptyViewType_NoNavAndTab
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /// 通知相关
    @objc func loginSuccess(notify: Notification) -> Void {
        self.rightTitle(title: "user")
    }
    
    @objc func logoutSuccess(notify: Notification) -> Void {
        self.rightTitle(title: "login")
    }
    
    // MAKR: - 加载数据
    override func queryData() -> Array<Any>? {
        
        let api = Topic_Get.init(offset: offset, limit: limit)
        api.call(async: true)
        return api.dataSource
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TopicCell = TopicCell.tcell(tableView: tableView, reuse: true) as! TopicCell
        
        let topic = self.dataSource![indexPath.row] as! Topic
        cell.showIndicator(flag: true)
        cell.updateTopic(topic: topic)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        self.clickCell(index: indexPath.row)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TopicCell.classCellHeight()
    }
    
    // 点击 cell 事件
    func clickCell(index: Int) {
        
        let topic = self.dataSource![index] as! Topic
        
        let vc = TopicDetailVC()
        vc.topicID = topic.topicID!.uuidString
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 空页面点击交互
    @objc override func emptyTapGesture() -> Void {
        self.loadData(more: false)
    }
    
    override func goBack() {
        if !WorkSpace.sharedInstance.appPreference.isLoginSuccess {
            UIHelper.show(title: "Please login first")
            return
        }
        let vc = TopicNewVC()
        let nav = UINavigationController.init(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    // 进入登录
    override func goNext() {
        
        if WorkSpace.sharedInstance.appPreference.isLoginSuccess {
            let vc = UserInfoVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = LoginVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
