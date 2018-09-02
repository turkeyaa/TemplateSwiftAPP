//
//  TopicNewApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class TopicNewApi: BaseRestApi {
    
    private var title: String = ""
    private var content: String = ""
    private var categoryId: Int = 0
    
    init(title: String, content: String, categoryId: Int) {
        super.init(url: "topic/new", httpMethod: .HttpMethods_Post)
        decodeType = .DecodeJSONTypeNone
        
        self.title = title
        self.content = content
        self.categoryId = categoryId
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        return true
    }
    
    override func queryToken() -> String {
        return WorkSpace.sharedInstance.appPreference.token
    }
    
    override func prepareRequestData() -> Dictionary<String, Any> {
        return [
            "title": title,
            "content": content,
            "categoryId": categoryId
        ]
    }
}
