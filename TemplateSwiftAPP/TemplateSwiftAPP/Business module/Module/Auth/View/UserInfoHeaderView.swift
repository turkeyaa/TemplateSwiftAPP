//
//  UserInfoHeaderView.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/4.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class UserInfoHeaderView: BaseView {
    
    override init(frame: CGRect) {
        icon = UIImage.init()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconView: UIImageView = {
        let view = UIImageView.init()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 4.0
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel.init()
        return view
    }()
    
    var icon: UIImage {
        willSet {
            
        }
        didSet {
            iconView.image = icon
        }
    }
    
    override func setupUI() {
        backgroundColor = UIColor.white
        addSubview(iconView)
        addSubview(titleLabel)
    }
    
    override func setupLayout() {
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(60)
            make.left.equalTo(20)
            make.centerY.equalTo(self.snp.centerY).offset(0)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.height.equalTo(30)
            make.right.equalTo(-20)
        }
    }
    
    func updateUI(user: User) -> Void {
        titleLabel.text = user.author
        let url = URL.init(string: URLHelper.sharedInstance.restImageURL() + user.authorImage)
        iconView.kf.setImage(with: url, placeholder: UIImage.init(named: "app_placeholder"), options: nil, progressBlock: { (receivedSize, totalSize) in
            let progress = Float(receivedSize) / Float(totalSize)
            SVProgressHUD.showProgress(progress)
            SVProgressHUD.setBackgroundColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5))
            SVProgressHUD.setForegroundColor(UIColor.white)
        }, completionHandler: { (image, error, cacheType, url) in
            SVProgressHUD.dismiss()
        })
    }
}
