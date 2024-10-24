//
//  UserInfoVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
//import TAssetPicker


class UserInfoVC: BaseFormGroupTC {
    
    var groupValueDataSource = [[]]
    
    lazy var exitBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.frame = CGRect.init(x: 30, y: 400, width: Device_width-60, height: 45)
        view.setTitle("logout", for: .normal)
        view.addTarget(self, action: #selector(logoutEvent), for: .touchUpInside)
        view.backgroundColor = UIColor.red
        return view
    }()
    
    lazy var userHeaderView: UserInfoHeaderView = {
        let view = UserInfoHeaderView.init(frame: CGRect.init(x: 0, y: 20, width: Device_width, height: 100))
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(assetEvent))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "info"
        self.rightTitle(title: "topics")
        
        groupDataSource = [["nick name","time","zone"],["homepage","sign"]]
        
        let user = WorkSpace.sharedInstance.user
        groupValueDataSource = [[user.nickName,DateUtil.timeStampToString(timeStamp: user.createTime),user.city],[user.website,user.sign]]
        
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 130.0
        }
        return 10.0
    }
    
    @objc func logoutEvent() -> Void {
        WorkSpace.sharedInstance.onLogOut()
        UIHelper.show(title: "logout successfully")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func assetEvent() -> Void {
        ActionHelper.showSheet(title: "", message: "type", actions: ["photo album","Camera"], vc: self) { (index) in
            if index == 0 {
                self.enterAlbum()
            } else {
                UIHelper.show(title: "todo - 暂不支持相机")
            }
        }
    }
    
    func enterAlbum() -> Void {
        
    }
    
    override func goNext() {
        let vc = UserCollect()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /*
    // todo 上传用户头像
    func p_updateUserIcon(icon: UIImage) -> Void {
        
        GCDUtil.runInGlobalQueue {
            
            self.showLoadingHUD(hud: "上传图片中")
            let api = UserUploadIcon_Post.init(icon: icon)
            api.call(asynchronous: true)
            
            sleep(1)
            
            GCDUtil.runInMainQueue {
                
                self.hideLoadingHUD()
                if api.code == .status_ok {
                    UIHelper.show(title: "上传图片成功")
                    WorkSpace.currentUser().authorImage = api.imageUrl
                    self.userHeaderView.icon = icon
                } else {
                    UIHelper.show(title: api.message)
                }
            }
        }
    }
     */
}
