//
//  Configuration.swift
//  AssetPicker
//
//  Created by yuwenhua on 2017/10/2.
//  Copyright © 2017年 DS. All rights reserved.
//

import Foundation
import UIKit

open class Configuration: NSObject {
    
    open var leftTitle: String = "取消"
    open var rightTitle: String = "完成"
    open var leftImage: UIImage?
    open var rightImage: UIImage?
    
    open var numberBgColor: UIColor = UIColor.brown
    
    open var titleColor: UIColor = UIColor.black
    
    open var maxCount: Int = 9
    
    public override init() {}
}
