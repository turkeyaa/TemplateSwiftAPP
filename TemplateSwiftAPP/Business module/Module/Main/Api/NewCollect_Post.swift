//
//  NewCollectApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class NewCollect_Post: BaseRestApi {
    
    private var topicID: String = ""
    
    init(topicID: String) {
        /*
        super.init(url: "topic/newCollect", httpMethod: .HttpMethods_Post)
        */
        
        super.init(url: "api/newCollect.json", httpMethod: .HttpMethods_Post)
        
        decodeType = .DecodeJSONTypeNone
        
        self.topicID = topicID
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        return false
    }
    
    override func queryToken() -> String {
        return WorkSpace.sharedInstance.appPreference.token
    }
    
    override func prepareRequestData() -> Dictionary<String, Any> {
        return [
            "topicID": topicID
        ]
    }
    
    /* Mock local resource json, for more expediently test
    override func mockFile() -> String {
        return "newCollect"
    }
    override func mockType() -> MockType {
        return .MockFile
    }
     */
}
