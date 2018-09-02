//
//  CommentListApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class CommentListApi: BaseRestApi {
    
    init(offset: Int, limit: Int, topicID: String) {
        super.init(url: "topic/commentList?topicID=\(topicID)", httpMethod: .HttpMethods_Get)
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        
        if let result = try? JSONDecoder().decode([Comment].self, from: json) {
            
            // 解析成功，赋值给:users对象
            self.dataSource = result
            return true;
        }
        
        return false
    }
}
