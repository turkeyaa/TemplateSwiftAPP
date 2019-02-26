//
//  Cagegory_Get.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/20.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class Category_Get: BaseRestApi {
    
    init() {
        super.init(url: "category/list", httpMethod: .HttpMethods_Get)
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        
        if let result = try? JSONDecoder().decode([Category].self, from: json) {
            // 解析成功，赋值给:users对象
            self.dataSource = result
            return true;
        }
        
        return false
    }
    
    override func mockFile() -> String {
        return "category"
    }
    
    override func mockType() -> MockType {
        return .MockFile
    }
}
