//
//  Topic.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/8/29.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class Topic: JSONModel,Codable {
    
    var topicID: UUID?
    var userID: UUID?
    var categoryId: Int = 0
    var likeNum: Int = 0
    var isGood: Int = 0
    var viewNum: Int = 0
    var collectNum: Int = 0
    var replyNum: Int = 0
    var createTime: TimeInterval = 0
    var author: String = ""
    var authorImage: String = ""
    var title: String = ""
    var content: String = ""
    
    override init() {
        super.init()
    }
    
    override init(dict: [String : Any]) {
        super.init(dict: dict)
        setValuesForKeys(dict)
    }
    
    /// 如果我们需要用不同的名称, 只需要提供我们自己的 CodingKey
    enum CodingKeys: String,CodingKey {
        case topicID = "id"
        case userID
        case categoryId
        case likeNum
        case isGood
        case viewNum
        case collectNum
        case replyNum
        case author
        case title
        case content
        case createTime
//        case authorImage
    }
}
