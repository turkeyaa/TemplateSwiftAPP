//
//  User.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation


class User: Codable {
    
    var name: String = ""
    var phone: String = ""
    var name_spell: String = ""
    var user_id: String = ""
    var avatar_url: String = ""
    
    /// 如果我们需要用不同的名称, 只需要提供我们自己的 CodingKey
    enum CodingKeys: String,CodingKey {
        case user_id = "userid"
        case name
        case name_spell
        case phone
        case avatar_url
    }
}

