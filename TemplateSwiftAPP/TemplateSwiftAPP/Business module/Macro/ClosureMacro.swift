//
//  ClosureMacro.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

// 分享回调,选择分享平台
typealias ShareViewItem = (Int) -> Void
typealias ShareViewBack = (Bool) -> Void


typealias BlockItem = (_ index: Int) -> Void
