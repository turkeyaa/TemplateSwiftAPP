//
//  Category.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/22.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class Category: JSONModel,Codable {
    
    var categoryID: Int?
    var name: String = ""
    var createTime: TimeInterval = 0
    
    override init() {
        super.init()
    }
    
    override init(dict: [String : Any]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
    
    /// 如果我们需要用不同的名称, 只需要提供我们自己的 CodingKey
    enum CodingKeys: String,CodingKey {
        case categoryID = "id"
        case name
        case createTime
    }
}
