//
//  ShareView.swift
//  TemplateSwift
//
//  Created by yuwenhua on 2017/9/21.
//  Copyright © 2017年 DS. All rights reserved.
//

import Foundation
import UIKit

class ShareView: UIView {
    
    var items: Int = 4
    var contentHeight: CGFloat = 150.0
    var shareWidth: CGFloat = 60.0
    
    var contentView: UIView
    var shareView: ShareViewItem?
    var cancelBtn: UIButton?
    
    var _titles: [String]
    var _images: [UIImage]
    
    /// 初始化方法
    init(titles: [String], images: [UIImage]) {
        
        _titles = titles
        _images = images
        items = images.count
        
        contentView = UIView.init()
        contentView.backgroundColor = UIColor.white
        contentView.frame = CGRect.init(x: 0, y: Device_height, width: Device_width, height: contentHeight)
        
        super.init(frame: CGRect.init(x: 0, y: 0, width: Device_width, height: Device_height))
        self.backgroundColor = UIColor.rgba(r: 0, g: 0, b: 0, alpha: 0.5)
        
        UIApplication.shared.keyWindow!.addSubview(self)
        self.addSubview(contentView)
        
        cancelBtn = UIButton.init()
        cancelBtn!.setTitle("取消", for: .normal)
        cancelBtn!.addTarget(self, action: #selector(hide), for: .touchUpInside)
        cancelBtn?.setTitleColor(UIColor.red, for: .normal)
        cancelBtn?.layer.borderColor = UIColor.lightGray.cgColor
        cancelBtn?.layer.borderWidth = 1.0
        cancelBtn?.layer.cornerRadius = 5.0
        contentView.addSubview(cancelBtn!)
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.hide))
        self.addGestureRecognizer(gesture)
        
        self.show()
        
        self.updateUI()
    }
    
    func updateUI() -> Void {
        
        let itemWidth = Device_width/CGFloat(items)
        var paddingX: CGFloat = 0.0
        for i in 0 ..< items {
            let title = _titles[i]
            let image: UIImage = _images[i]
            
            let imgView = UIImageView.init(frame: CGRect.init(x: paddingX+(itemWidth-shareWidth)/2.0, y: 0, width: shareWidth, height: shareWidth))
            imgView.image = image
            imgView.tag = i
            imgView.isUserInteractionEnabled = true
            contentView.addSubview(imgView)
            
            let label = UILabel.init()
            label.text = title
            label.textAlignment = .center
            label.frame = CGRect.init(x: paddingX, y: 60, width: itemWidth, height: 20)
            contentView.addSubview(label)
            
            paddingX += itemWidth
            
            let shareGesture = UITapGestureRecognizer.init(target: self, action: #selector(shareEvent(gesture:)))
            imgView.addGestureRecognizer(shareGesture)
        }
        cancelBtn!.frame = CGRect.init(x: 50, y: 100, width: Device_width-100, height: 40)
    }
    
    @objc func shareEvent(gesture: UITapGestureRecognizer) -> Void {
        hide()
        
//        let index = gesture.view?.tag
//        shareView!(index!)
    }
    
    @objc func hide() -> Void {
        UIView.animate(withDuration: 0.4, animations: {
            self.contentView.frame = CGRect.init(x: 0, y: Device_height, width: Device_width, height: self.contentHeight)
        }) { (flag) in
            self.removeFromSuperview()
        }
    }
    
    func show() -> Void {
        UIView.animate(withDuration: 0.4, animations: {
            self.contentView.frame = CGRect.init(x: 0, y: Device_height-self.contentHeight, width: Device_width, height: self.contentHeight)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

