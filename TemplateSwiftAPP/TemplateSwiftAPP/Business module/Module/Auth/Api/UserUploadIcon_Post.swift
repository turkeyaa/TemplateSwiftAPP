//
//  UserUploadIcon_Post.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/11.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class UserUploadIcon_Post: BaseUploadApi {
    
    let icon: UIImage
    var imageUrl: String = ""
    
    init(icon: UIImage) {
        self.icon = icon
        super.init(url: "user/updateUserIcon", httpMethod: .HttpMethods_File)
    }
    
    override func prepareRequestData() -> Dictionary<String, Any> {
        return [
            "type": "iOS",
            "image": icon
        ]
    }
    
    override func parseResponseJsonString(json: Data) -> Bool {
        let result = String.init(data: json, encoding: String.Encoding.utf8)
        if result != nil && result!.count > 0 {
            imageUrl = result!
            return true
        }
        
        return false
    }
    
    override func queryToken() -> String {
        return WorkSpace.sharedInstance.appPreference.token
    }
}
