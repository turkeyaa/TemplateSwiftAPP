//
//  UserInfo_Post.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/1.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class UserInfo_Post: BaseRestApi {
    
    var user: User?
    
    init() {
        super.init(url: "user/user", httpMethod: .HttpMethods_Post)
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        
        if let result = try? JSONDecoder().decode(User.self, from: json) {
            // 解析成功，赋值给:users对象
            self.user = result
            return true;
        }
        
        return false
    }
    
    // 模拟本地接口，方便测试，需要在项目中添加相应的JSON数据（Resource目录）
    override func mockFile() -> String {
        return "userInfo"
    }
    override func mockType() -> MockType {
        return .MockFile
    }
}
