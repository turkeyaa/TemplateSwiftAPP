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
        
        var request: URLRequest = URLRequest(url: URL.init(string: _url!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
        request.httpMethod = "POST"
        
        let formData = self.queryPostData2()
        
        request.setValue(String(formData.count), forHTTPHeaderField:"Content-Length")
        request.addValue(queryContentType(), forHTTPHeaderField: "Content-Type")
        
        /// 自定义header - token
        request.addValue(self.configToken(), forHTTPHeaderField: "Authorization")
        
        let condition = NSCondition.init()
        
        let session: URLSession = URLSession.shared
        
        task = session.uploadTask(with: request, from: formData, completionHandler: { (data, resp, error) in
            
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
    
    func queryPostData2() -> Data {
        
        
        let BOUNDRY_B = "WebKitFormBoundaryrGKCBY7qhFd3TrwA"
        let MPboundary = "--" + BOUNDRY_B
        let endMPboundary = "--" + BOUNDRY_B + "--"
        let ENTER = "\r\n"
        
        let formString = MPboundary + ENTER + "Content-Disposition: form-data; name=type" + ENTER + ENTER + "iOS" + ENTER + MPboundary + ENTER + "Content-Disposition: form-data; name=image; filename=user.png" + ENTER + ENTER
        
        let formData = NSMutableData.init()
        
        /// 添加非图片参数数据
        formData.append(formString.data(using: String.Encoding.utf8)!)
        /// 添加图片数据
        let image = UIImage.init(named: "app_qq")
        formData.append(UIImagePNGRepresentation(image!)!)
        /// 添加结尾
        formData.append((ENTER + endMPboundary).data(using: String.Encoding.utf8)!)
        
        return formData as Data
    }
    
    override func queryPostData() -> Data {
        
        let BOUNDRY_B = "WebKitFormBoundaryrGKCBY7qhFd3TrwA"
        let MPboundary = "--" + BOUNDRY_B
        let endMPboundary = "--" + BOUNDRY_B + "--"
        let ENTER = "\r\n"
        
        let formData = NSMutableData.init()
        
        let requestData = self.prepareRequestData()
        
        
        for value in requestData {
            if let image = value.value as? UIImage {
                /// 图片
                formData.append((MPboundary + ENTER).data(using: String.Encoding.utf8)!)
                formData.append("Content-Disposition: form-data; name=\"\(value.key)\"; filename=\"user.jpg\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                formData.append(UIImagePNGRepresentation(image)!)
            } else {
                formData.append((MPboundary + ENTER).data(using: String.Encoding.utf8)!)
                formData.append("Content-Disposition: form-data; name=\"\(value.key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                formData.append((value.key as String + ENTER).data(using: String.Encoding.utf8)!)
            }
        }
        
        formData.append((ENTER + endMPboundary).data(using: String.Encoding.utf8)!)
        
        return formData as Data
    }
    
    /// 上传图片参数 - request
    func queryContentType() -> String {
        return "multipart/form-data; boundary=WebKitFormBoundaryrGKCBY7qhFd3TrwA"
    }
}
