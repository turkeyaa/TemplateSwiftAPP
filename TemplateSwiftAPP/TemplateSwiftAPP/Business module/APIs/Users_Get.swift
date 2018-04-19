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
        super.init(url: "/template/user", httpMethod: .HttpMethods_Get)
        
        // 用户列表为数组结合,需要重新设置解析类型
        self.decodeType = DecodeJSONType.DecodeJSONTypeArray
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        
        if let result = try? JSONDecoder().decode([User].self, from: json) {
            // 解析成功，赋值给:users对象
            self.dataSource = result
            return true;
        }
        
        return false
    }
    
    // 模拟本地接口，方便测试，需要在项目中添加相应的JSON数据（Resource目录）
    override func mockFile() -> String {
        return "users"
    }
    override func mockType() -> MockType {
        return .MockFile
    }
}
