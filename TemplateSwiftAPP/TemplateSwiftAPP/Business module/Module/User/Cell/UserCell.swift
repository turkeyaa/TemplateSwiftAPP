//
//  UserCell.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/30.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import Kingfisher

class UserCell: BaseTCell {
    
    var iconView: UIImageView?
    var nameLabel: UILabel?
    
    override class func classCellHeight() -> CGFloat {
        return 100.0
    }
    
    override func setupSubViews() {
        
        nameLabel = UILabel.init()
        iconView = UIImageView.init()
        
        self.addSubview(nameLabel!)
        self.addSubview(iconView!)
        
        self.setupLayouts()
    }
    
    override func setupLayouts() {
        
        iconView?.snp.makeConstraints({ (make) -> Void in
            make.left.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.equalTo((iconView?.snp.height)!)
        })
        nameLabel?.snp.makeConstraints({ (make) -> Void in
            make.left.equalTo((iconView?.snp.right)!).offset(10)
            make.height.equalTo(40)
            make.centerY.equalTo(self.snp.centerY)
        })
    }
    
    func updateUser(user: User) -> Void {
        nameLabel?.text = user.name
        
        let url = URL.init(string: user.avatar_url)!
        iconView?.kf.setImage(with: url, placeholder: UIImage.init(named: "placeholder"), options: nil, progressBlock: { (receivedSize, totalSize) in
            let progress = Float(receivedSize) / Float(totalSize)
            SVProgressHUD.showProgress(progress)
            SVProgressHUD.setBackgroundColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5))
            SVProgressHUD.setForegroundColor(UIColor.white)
        }, completionHandler: { (image, error, cacheType, url) in
            SVProgressHUD.dismiss()
        })
    }
}
