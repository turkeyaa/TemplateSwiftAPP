//
//  Login_Post.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/30.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class Login_Post: BaseRestApi {
    
    var token: String = ""
    
    init(account: String, password: String) {
        super.init(url: "auth/login", httpMethod: .HttpMethods_Post)
        decodeType = .DecodeJSONTypeString;   // token 字符串
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        
        let result = json.base64EncodedString()
        if result.count > 0 {
            token = result
            return true
        }
        
        return false
    }
    
//    override func prepareRequestData() -> Dictionary<String, Any> {
//        
//    }
    
    // 模拟本地接口，方便测试，需要在项目中添加相应的JSON数据（Resource目录）
    override func mockFile() -> String {
        return "login"
    }
    override func mockType() -> MockType {
        return .MockFile
    }
}
