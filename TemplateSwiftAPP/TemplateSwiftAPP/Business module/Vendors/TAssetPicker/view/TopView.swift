//
//  TopView.swift
//  TemplateSwift
//
//  Created by yuwenhua on 2017/10/2.
//  Copyright © 2017年 DS. All rights reserved.
//

import Foundation
import UIKit

class TopView: UIView {
    
//    var closeBack: TASAssetItemBlock?
//    var completionBack: TASAssetItemBlock?
    var clickItemBlock: TASAssetItemBlock?
    
    var configu = Configuration() {
        willSet(newValue) {
            
        }
        didSet {
            updateUI()
        }
    }
    
    lazy var closeBtn: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(closeEvent), for: .touchUpInside)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.frame = CGRect.init(x: 10, y: 10, width: 30, height: 30)
        return button
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.text = "全部照片"
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.frame = CGRect.init(x: 50, y: 10, width: TASDevice_width-100, height: 30)
        return label
    }()
    lazy var numberLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.layer.cornerRadius = 15.0
        label.backgroundColor = UIColor.brown
        label.clipsToBounds = true
        label.textColor = UIColor.white
        label.isHidden = true
        label.frame = CGRect.init(x: TASDevice_width-80, y: 10, width: 30, height: 30)
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent))
        label.addGestureRecognizer(tap)
        return label
    }()
    lazy var compBtn: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(completionEvent), for: .touchUpInside)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.frame = CGRect.init(x: TASDevice_width-50, y: 10, width: 30, height: 30)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(closeBtn)
        addSubview(titleLabel)
        addSubview(numberLabel)
        addSubview(compBtn)
    }
    
    convenience init(frame: CGRect, configu: Configuration) {
        self.init(frame: frame)
        self.configu = configu
        updateUI()
    }
    
    func updateUI() -> Void {
        if configu.leftTitle.count > 0 {
            closeBtn.setImage(nil, for: .normal)
            closeBtn.setTitle(configu.leftTitle, for: .normal)
            closeBtn.frame = CGRect.init(x: 10, y: 10, width: 40, height: 30)
        }
        if configu.rightTitle.count > 0 {
            compBtn.setImage(nil, for: .normal)
            compBtn.setTitle(configu.rightTitle, for: .normal)
            compBtn.frame = CGRect.init(x: TASDevice_width-50, y: 10, width: 40, height: 30)
        }
        if configu.leftImage != nil {
            closeBtn.setTitle("", for: .normal)
            closeBtn.setImage(configu.leftImage!, for: .normal)
        }
        if configu.rightImage != nil {
            compBtn.setTitle("", for: .normal)
            compBtn.setImage(configu.rightImage, for: .normal)
        }
        
        numberLabel.backgroundColor = configu.numberBgColor
        titleLabel.textColor = configu.titleColor
    }
    
    @objc func closeEvent() -> Void {
        if clickItemBlock != nil {
            clickItemBlock!(0)
        }
    }
    @objc func completionEvent() -> Void {
        if clickItemBlock != nil {
            clickItemBlock!(1)
        }
    }
    @objc func tapEvent() -> Void {
        if clickItemBlock != nil {
            clickItemBlock!(2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
