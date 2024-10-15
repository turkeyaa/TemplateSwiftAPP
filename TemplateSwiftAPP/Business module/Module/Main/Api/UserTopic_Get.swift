//
//  UserTopic_Get.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class UserTopic_Get: BaseRestApi {
    
    init(offset: Int, limit: Int) {
        /*
        super.init(url: "UserTopic/topicList?offset=\(offset)&limit=\(limit)", httpMethod: .HttpMethods_Get)
         */
        super.init(url: "api/userTopicList.json", httpMethod: .HttpMethods_Get)
    }
    
    override func queryToken() -> String {
        return WorkSpace.sharedInstance.appPreference.token
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
        return "userTopicList"
    }
    override func mockType() -> MockType {
        return .MockFile
    }
     */
}
