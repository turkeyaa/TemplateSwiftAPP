//
//  UserInfoVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
import TAssetPicker

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
        let view = UserInfoHeaderView.init(frame: CGRect.init(x: 0, y: 20, width: Device_width, height: 100))
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(assetEvent))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "用户信息"
        self.rightTitle(title: "我发布的")
        self.leftIcon(icon: UIImage.init(named: "app_back")!)
        
        groupDataSource = [["昵称","加入时间","地区"],["主页","签名"]]
        
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
            return 130.0
        }
        return 10.0
    }
    
    @objc func logoutEvent() -> Void {
        WorkSpace.sharedInstance.onLogOut()
        UIHelper.show(title: "退出登录成功")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func assetEvent() -> Void {
        ActionHelper.showSheet(title: "", message: "选择类型", actions: ["访问相册","访问相机"], vc: self) { (index) in
            if index == 0 {
                self.enterAlbum()
            } else {
                UIHelper.show(title: "todo - 暂不支持相机")
            }
        }
    }
    
    func enterAlbum() -> Void {
        
        let configu = AssetConfiguration.init()
        configu.leftTitle = "取消"
        configu.rightTitle = "完成"
//        configu.leftImage = UIImage.init(named: "app_closed")
//        configu.rightImage = UIImage.init(named: "app_completion")
        configu.selectImage = UIImage.init(named: "app_select")
        configu.deselectImage = UIImage.init(named: "app_deselect")
        configu.maxCount = 1    // 最大可选中图片数量
        
        configu.numberBgColor = UIColor.orange     // 数量背景颜色
        
        let vc = AssetPickerController.init(configu: configu)
        
        vc.assetResult = { (result: [UIImage]) in
            print(result)   // UIImage 数组对象
            if result.count > 0 {
                let icon = result[0]
                self.p_updateUserIcon(icon: icon)
            }
        }
        vc.errorResult = { (index: Int) in
            if index == 0 {
                UIHelper.show(title: "只能选择\(configu.maxCount)张图片")
            }
        }
        present(vc, animated: true, completion: nil)
    }
    
    override func goNext() {
        let vc = UserCollect()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// api
    // 上传用户头像
    func p_updateUserIcon(icon: UIImage) -> Void {
        
        GCDHelper.runInGlobalQueue {
            self.showLoadingHUD(hud: "上传图片中")
            let api = UserUploadIcon_Post.init(icon: icon)
            api.call(async: true)
            GCDHelper.runInMainQueue {
                self.hideLoadingHUD()
                
                if api.code == .status_ok {
                    UIHelper.show(title: "上传图片成功")
                    self.userHeaderView.icon = icon
                } else {
                    UIHelper.show(title: api.message)
                }
            }
        }
        
    }
}
