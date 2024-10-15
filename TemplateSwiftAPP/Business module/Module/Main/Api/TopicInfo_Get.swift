//
//  TopinInfoApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class TopicInfo_Get: BaseRestApi {
    
    var topic: Topic = Topic()
    
    init(topicID: String) {
//        super.init(url: "topic/info?topicID=\(topicID)", httpMethod: .HttpMethods_Get)
        
        // Mock Github api
        super.init(url: "Resource/sample.md", httpMethod: .HttpMethods_Get)
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        
        if let result = try? JSONDecoder().decode(Topic.self, from: json) {
            // 解析成功，赋值给:users对象
            self.topic = result
            return true;
        }
        
        return false
    }
    
    /* Mock local resource json, for more expediently test
    override func mockFile() -> String {
        return "topicInfo"
    }
    override func mockType() -> MockType {
        return .MockFile
    }
     */
}
