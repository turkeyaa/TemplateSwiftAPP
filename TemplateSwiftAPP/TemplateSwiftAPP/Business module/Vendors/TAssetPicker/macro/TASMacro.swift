//
//  UIMacro.swift
//  TemplateSwift
//
//  Created by yuwenhua on 2017/3/1.
//  Copyright © 2017年 DS. All rights reserved.
//

import Foundation
import UIKit

/// 尺寸相关
let TASDevice_width: CGFloat = UIScreen.main.bounds.width
let TASDevice_height: CGFloat = UIScreen.main.bounds.height
let TASDevice_nav: CGFloat = 44.0
let TASDevice_tab: CGFloat = 49.0
let TASDevice_status: CGFloat = 20.0

/// 闭包定义
typealias TASAssetItemBlock = (_ index: Int) -> Void                // 关闭、完成、选择回调

///
public typealias TASAssetErrorTypeBlock = (_ index: Int) -> Void     // 错误状态码回调
public typealias TASAssetInfoBlock = ([UIImage]) -> Void

