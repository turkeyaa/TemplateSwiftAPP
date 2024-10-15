//
//  Topic_Get.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/8/29.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class Topic_Get: BaseRestApi {
    
    init(offset: Int, limit: Int) {
        
        /*
        super.init(url: "topic/list?offset=\(offset)&limit=\(limit)", httpMethod: .HttpMethods_Get)
        */
        
        // Mock Github api
        super.init(url: "api/topicList.json", httpMethod: .HttpMethods_Get)
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        
        if let result = try? JSONDecoder().decode([Topic].self, from: json) {
            // 解析成功，赋值给:users对象
            self.dataSource = result
            return true;
        }
        
        return false
    }
    
    /* Mock local resource json, for more expediently test
    override func mockFile() -> String {
        return "topicList"
    }
    override func mockType() -> MockType {
        return .MockNone
    }
     */
}
