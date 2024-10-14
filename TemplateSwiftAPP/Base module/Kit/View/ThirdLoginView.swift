//
//  ThirdLoginView.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/10/15.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class ThirdLoginView: UIView {
    
    private var items: Int = 4
    private var contentHeight: CGFloat = 150.0
    private var shareWidth: CGFloat = 50.0
    
    private var _titles: [String]
    private var _images: [UIImage]
    
    var clickItemBlock: BlockItem?
    
    ///
    init(frame: CGRect, titles: [String], images: [UIImage]) {
        
        _titles = titles
        _images = images
        
        super.init(frame: frame)
        
        items = images.count
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() -> Void {
        
        /// ------------ share to -----------
        let dashLineView = UIView(frame: CGRect(x: 10, y:0, width: frame.size.width-20, height: 5))
        dashLineView.drawDashLine(strokeColor: .lightGray)
        self.addSubview(dashLineView)
        
        let itemWidth = Device_width/CGFloat(items)
        var paddingX: CGFloat = 0.0
        for i in 0 ..< items {
            let title = _titles[i]
            let image: UIImage = _images[i]
            
            let imgView = UIImageView.init(frame: CGRect.init(x: paddingX+(itemWidth-shareWidth)/2.0, y: 20, width: shareWidth, height: shareWidth))
            imgView.image = image
            imgView.tag = i
            imgView.isUserInteractionEnabled = true
            addSubview(imgView)
            
            let label = UILabel.init()
            label.text = title
            label.textAlignment = .center
            label.textColor = ColorMacro.ColorText666
            label.font = FontMacro.font14
            label.frame = CGRect.init(x: paddingX, y: 70, width: itemWidth, height: 20)
            addSubview(label)
            
            paddingX += itemWidth
            
            let shareGesture = UITapGestureRecognizer.init(target: self, action: #selector(shareEvent(gesture:)))
            imgView.addGestureRecognizer(shareGesture)
        }
    }
    
    @objc func shareEvent(gesture: UITapGestureRecognizer) -> Void {
        
        let index = gesture.view!.tag
        if clickItemBlock != nil {
            clickItemBlock!(index)
        }
    }
}
