//
//  CategoryTopic_Get.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/22.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class CategoryTopic_Get: BaseRestApi {
    
    init(offset: Int, limit: Int, categoryId: Int) {
        super.init(url: "topic/categoryTopicList?offset=\(offset)&limit=\(limit)&categoryId=\(categoryId)", httpMethod: .HttpMethods_Get)
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
        return "categoryTopicList"
    }
    override func mockType() -> MockType {
        return .MockFile
    }
     */
}
