//
//  User.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class User: Codable {
    
    var name: String
    var phone: String
    var name_spell: String
    var user_id: String
    var avatar_url: String
    
    init(name: String, phone: String, name_spell: String, user_id: String, avatar_url: String) {
        self.name = name
        self.phone = phone
        self.name_spell = name_spell
        self.user_id = user_id
        self.avatar_url = avatar_url
    }
    
    enum CodingKeys: String,CodingKey {
        case user_id = "userid"
        case name
        case name_spell
        case phone
        case avatar_url
    }
}
