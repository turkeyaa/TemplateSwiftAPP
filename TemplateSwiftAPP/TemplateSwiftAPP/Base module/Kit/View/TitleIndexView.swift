//
//  IndexView.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/20.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

private let kTitleWidth = 60

class TitleIndexView: UIView {
    
    private let titles: [String]
    private let bottomLineColor: UIColor = ColorMacro.ColorCellLine
    
    var currentIndex: Int = 0 {
        didSet {
            self.indexEvent(index: currentIndex)
        }
    }
    
    var lastIndex: Int = 0
    
    var titleColor: UIColor = UIColor.darkGray
    var titleSelectColor: UIColor = UIColor.orange
    
    var isShowTitleLine: Bool = false
    var titleLineColor: UIColor = UIColor.orange
    
    var clickItemBlock: BlockItem?
    
    lazy var scrollerView: UIScrollView = {
        let view = UIScrollView.init(frame: self.bounds)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    lazy var bottomLineView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.bounds.size.height-1.5, width: self.frame.size.width, height: 1))
        view.backgroundColor = ColorMacro.ColorLine
        return view
    }()
    lazy var titleLineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = titleLineColor
        return view
    }()
    
    init(titles: [String], frame: CGRect) {
        self.titles = titles
        super.init(frame: frame)
        
        addSubview(scrollerView)
        scrollerView.addSubview(bottomLineView)
        scrollerView.addSubview(titleLineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() -> Void {
        
        if titles.count == 0 {
            return
        }
        for index in 0..<titles.count {
            let title = titles[index]
            
            let button = UIButton.init(type: .custom)
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.setTitleColor(titleSelectColor, for: .selected)
            if index == 0 {
                button.isSelected = true
            }
            button.tag = 1000+index
            button.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
            button.frame = CGRect.init(x: kTitleWidth*index, y: 0, width: kTitleWidth, height: Int(self.frame.size.height-1))
            scrollerView.addSubview(button)
        }
        
        scrollerView.contentSize = CGSize.init(width: kTitleWidth * titles.count, height: Int(self.frame.size.height))
        
        /// 更新初始值
        indexEvent(index: currentIndex)
    }
    
    @objc func buttonEvent(sender: UIButton) -> Void {
        if sender.isSelected {
            return
        }
        currentIndex = sender.tag - 1000
        
        if clickItemBlock != nil {
            clickItemBlock!(currentIndex)
        }
    }
    
    func indexEvent(index: Int) -> Void {
        
        let lastBtn: UIButton = viewWithTag(lastIndex+1000) as! UIButton
        lastBtn.isSelected = false
        
        let currentBtn: UIButton = viewWithTag(currentIndex+1000) as! UIButton
        currentBtn.isSelected = true
        
        titleLineView.frame = CGRect.init(x: index*kTitleWidth, y: Int(self.frame.size.height-4), width: kTitleWidth, height: 3)
        
        lastIndex = currentIndex
    }
    
}
