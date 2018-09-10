//
//  NewLikeApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class NewLike_Post: BaseRestApi {
    
    private var topicID: String = ""
    
    init(topicID: String) {
        super.init(url: "topic/newLike", httpMethod: .HttpMethods_Post)
        decodeType = .DecodeJSONTypeNone
        
        self.topicID = topicID
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        return true
    }
    
    override func queryToken() -> String {
        return WorkSpace.sharedInstance.appPreference.token
    }
    
    override func prepareRequestData() -> Dictionary<String, Any> {
        return [
            "topicID": topicID
        ]
    }
}
