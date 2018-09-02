//
//  NewCommentApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class NewCommentApi: BaseRestApi {
    
    private var topicID: String = ""
    private var content: String = ""
    
    init(topicID: String, content: String) {
        super.init(url: "topic/newComment", httpMethod: .HttpMethods_Post)
        decodeType = .DecodeJSONTypeNone
        
        self.topicID = topicID
        self.content = content
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        return true
    }
    
    override func queryToken() -> String {
        return WorkSpace.sharedInstance.appPreference.token
    }
    
    override func prepareRequestData() -> Dictionary<String, Any> {
        return [
            "topicID": topicID,
            "content": content
        ]
    }
}
