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
    
    private var items: Int = 4
    private var contentHeight: CGFloat = 150.0
    private var shareWidth: CGFloat = 50.0
    
    private var contentView: UIView
    private var cancelBtn: UIButton?
    
    private var _titles: [String]
    private var _images: [UIImage]
    
    var clickItemBlock: BlockItem?
    
    /// 初始化方法
    init(titles: [String], images: [UIImage]) {
        
        _titles = titles
        _images = images
        items = images.count
        
        contentView = UIView.init()
        contentView.backgroundColor = UIColor.white
        
        super.init(frame: CGRect.init(x: 0, y: 0, width: Device_width, height: Device_height))
        self.backgroundColor = UIColor.rgba(r: 0, g: 0, b: 0, alpha: 0.5)
        
        UIApplication.shared.keyWindow!.addSubview(self)
        self.addSubview(contentView)
        
        cancelBtn = UIButton.init()
        cancelBtn!.setTitle("取消", for: .normal)
        cancelBtn!.addTarget(self, action: #selector(hide), for: .touchUpInside)
        cancelBtn?.setTitleColor(UIColor.orange, for: .normal)
        cancelBtn?.layer.borderColor = UIColor.init(white: 0.5, alpha: 0.5).cgColor
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
            
            let imgView = UIImageView.init(frame: CGRect.init(x: paddingX+(itemWidth-shareWidth)/2.0, y: 10, width: shareWidth, height: shareWidth))
            imgView.image = image
            imgView.tag = i
            imgView.isUserInteractionEnabled = true
            contentView.addSubview(imgView)
            
            let label = UILabel.init()
            label.text = title
            label.textAlignment = .center
            label.textColor = ColorMacro.ColorText666
            label.font = FontMacro.font14
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
        
        let index = gesture.view!.tag
        if clickItemBlock != nil {
            clickItemBlock!(index)
        }
    }
    
    @objc func hide() -> Void {
        self.alpha = 1.0
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 0.0
            self.contentView.frame = CGRect.init(x: 0, y: Device_height, width: Device_width, height: self.contentHeight)
        })
    }
    
    func show() -> Void {
        self.alpha = 0.0
        self.contentView.frame = CGRect.init(x: 0, y: Device_height, width: Device_width, height: self.contentHeight)
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 1.0
            self.contentView.frame = CGRect.init(x: 0, y: Device_height-self.contentHeight, width: Device_width, height: self.contentHeight)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

