//
//  BaseView.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    private var setInit: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() -> Void {
        if setInit == false {
            setInit = true
            setupUI()
            setupLayout()
        }
    }
    
    /// 子类重写的方法
    func setupUI() -> Void {}
    func setupLayout() -> Void {}
}
