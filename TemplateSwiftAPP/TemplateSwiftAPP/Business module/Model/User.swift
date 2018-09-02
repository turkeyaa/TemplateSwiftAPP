//
//  User.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation


class User: JSONModel,Codable {
    
    var userID: UUID?
    var account: String = ""
    var website: String = ""
    var author: String = ""
    var city: String = ""
    var company: String = ""
    var sign: String = ""
    var nickName: String = ""
    var createTime: TimeInterval = 0
    var avatarUrl: String = ""
    
    override init() {
        super.init()
    }
    
    override init(dict: [String : Any]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
    
    /// 如果我们需要用不同的名称, 只需要提供我们自己的 CodingKey
    enum CodingKeys: String,CodingKey {
        case userID = "id"
        case account
        case website
        case author
        case city
        case company
        case sign
        case nickName
        case createTime
    }
}


