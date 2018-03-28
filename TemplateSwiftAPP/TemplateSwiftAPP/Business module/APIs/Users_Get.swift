//
//  Users_Get.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class Users_Get: BaseRestApi {
    
    init() {
        super.init(url: "user/users", httpMethod: .HttpMethods_Get)
    }
    
    override func parseResponseJsonString(json: String) -> Bool {
        
        return false
        
//        if let users = [User].deserialize(from: json, designatedPath: "result") {
//
//            // 赋值
//            dataSource = users as? [User]
//        }
//        if (dataSource?.count)! > 0 {
//            return true
//        }
//        else {
//            return false
//        }
        
    }
    
    // 模拟本地接口，方便测试，需要在项目中添加相应的JSON数据（Resource目录）
    override func mockFile() -> String {
        return "users"
    }
    override func mockType() -> MockType {
        return .MockFile
    }
}
