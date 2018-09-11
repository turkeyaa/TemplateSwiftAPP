//
//  BaseUploadApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

/** 上传图片基类
 */

class BaseUploadApi: BaseRestApi {
    
    
    override func call(async: Bool) {
        
        if Thread.isMainThread {
            assert(false, "主线程不允许同步调用")
            return
        }
        
        var request: URLRequest?
        
        request = URLRequest(url: URL.init(string: _url!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
        request?.httpMethod = "POST"
        
        let formData = self.queryPostData()
        
//        request?.setValue(formData?.length, forHTTPHeaderField:"Content-Length")
        request?.addValue(queryContentType(), forHTTPHeaderField: "Content-Type")
        request?.httpBody = formData
        
        /// 自定义header - token
        request?.addValue(self.configToken(), forHTTPHeaderField: "Authorization")
        
        let condition = NSCondition.init()
        
        let session: URLSession = URLSession.shared
        
        task = session.uploadTask(with: request!, from: formData, completionHandler: { (data, resp, error) in
            
            if error != nil {
                print(error.debugDescription)
                super.onError(error: error!)
            }
            else {
                if let response = resp as? HTTPURLResponse {
                    
                    if response.statusCode == 200 {
                        
                        super.onSuccessed(response: data!)
                    } else {
                        //通知UI接口执行失败
                        super.onFailed(error: error)
                    }
                }
            }
            
            condition.lock()
            condition.signal()
            condition.unlock()
            
        }) as URLSessionUploadTask?
        
        task!.resume()
        
        condition.lock()
        condition.wait()
        condition.unlock()
    }
    
    override func queryPostData() -> Data {
        
        let BOUNDRY_B = "WebKitFormBoundaryrGKCBY7qhFd3TrwA"
        let MPboundary = "--" + BOUNDRY_B
        let endMPboundary = BOUNDRY_B + "--"
        let ENTER = "\r\n"
        //        let contentType: String = "multipart/form-data;boundary=" + BOUNDRY_B
        
        let formData = NSMutableData.init()
        
        let requestData = self.prepareRequestData()
        
        for value in requestData {
            if value.value is UIImage {
                /// 图片
                formData.append((MPboundary + ENTER).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!)
                formData.append("Content-Disposition: form-data; name=\"\(value.key)\"; filename=\"user.jpg\"\r\n\r\n".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!)
            } else {
                formData.append((MPboundary + ENTER).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!)
                formData.append("Content-Disposition: form-data; name=\"\(value.key)\"\r\n\r\n".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!)
                formData.append((value.key as String + ENTER).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!)
            }
        }
        
        formData.append((ENTER + endMPboundary).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!)
        
        return formData as Data
    }
    
    /// 上传图片参数 - request
    func queryContentType() -> String {
        return "multipart/form-data;boundary=WebKitFormBoundaryrGKCBY7qhFd3TrwA"
    }
}
