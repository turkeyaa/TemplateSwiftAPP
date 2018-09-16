//
//  BaseUploadApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

/** 上传图片基类
 */

class BaseUploadApi: BaseRestApi {
    
    override init(url: String, httpMethod: HttpMethods) {
        super.init(url: url, httpMethod: httpMethod)
        decodeType = .DecodeJSONTypeString;             // 图片路径
    }
    
    override func call(async: Bool) {
        
//        let condition = NSCondition.init()
//
//        condition.lock()
//        condition.wait()
//        condition.unlock()
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            /** 构造数据类型 */
            var params: [String: String] = [:]
            var image: UIImage?
            var fileKey: String = ""
            for value in self.prepareRequestData() {
                if value.value is UIImage {
                    image = value.value as? UIImage
                    fileKey = value.key
                } else {
                    params[value.key] = value.value as? String
                }
            }
            
            let data = UIImageJPEGRepresentation(image!, 1)
            
            let fileName = "image.png"
            
            // withName:：是根据文档决定传入的字符串
            multipartFormData.append(data!, withName: fileKey, fileName: fileName, mimeType: "image/png")
            
            // 遍历添加参数
            for (key, value) in params {
                // string 转 data
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: _url, headers: ["Authorization":self.configToken()], encodingCompletion: { (encodingResult) in
            
            switch encodingResult {
                
                case .success(let upload, _, _):
                    upload.responseJSON { response in
//                        condition.lock()
//                        condition.signal()
//                        condition.unlock()
                        let result = response.result.value as! [String: Any]
                        let data = try? JSONSerialization.data(withJSONObject: result)
                        super.onSuccessed(response: data!)
                    }
                case .failure(let encodingError):
//                    condition.lock()
//                    condition.signal()
//                    condition.unlock()
                    super.onError(error: encodingError)
            }
        })
    }
    
//    override func call(async: Bool) {
//
//        if Thread.isMainThread {
//            assert(false, "主线程不允许同步调用")
//            return
//        }
//
//        var request: URLRequest = URLRequest(url: URL.init(string: _url!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
//        request.httpMethod = "POST"
//
//        let formData = self.queryPostData2()
//
//        request.setValue(String(formData.count), forHTTPHeaderField:"Content-Length")
//        request.setValue(queryContentType(), forHTTPHeaderField: "Content-Type")
//
//        /// 自定义header - token
//        request.setValue(self.configToken(), forHTTPHeaderField: "Authorization")
//
//        let condition = NSCondition.init()
//
//        let session: URLSession = URLSession.shared
//
//        task = session.uploadTask(with: request, from: formData, completionHandler: { (data, resp, error) in
//
//            if error != nil {
//                print(error.debugDescription)
//                super.onError(error: error!)
//            }
//            else {
//                if let response = resp as? HTTPURLResponse {
//
//                    if response.statusCode == 200 {
//
//                        super.onSuccessed(response: data!)
//                    } else {
//                        //通知UI接口执行失败
//                        super.onFailed(error: error)
//                    }
//                }
//            }
//
//            condition.lock()
//            condition.signal()
//            condition.unlock()
//
//        }) as URLSessionUploadTask?
//
//        task!.resume()
//
//        condition.lock()
//        condition.wait()
//        condition.unlock()
//    }
    
//    override func queryPostData() -> Data {
//
//        let BOUNDRY_B = "WebKitFormBoundaryrGKCBY7qhFd3TrwA"
//        let MPboundary = "--" + BOUNDRY_B
//        let endMPboundary = "--" + BOUNDRY_B + "--"
//        let ENTER = "\r\n"
//
//        let formData = NSMutableData.init()
//
//        let requestData = self.prepareRequestData()
//
//
//        for value in requestData {
//            if let image = value.value as? UIImage {
//                /// 图片
//                formData.append((MPboundary + ENTER).data(using: String.Encoding.utf8)!)
//                formData.append("Content-Disposition: form-data; name=\"\(value.key)\"; filename=\"user.jpg\"\r\n\r\n".data(using: String.Encoding.utf8)!)
//                formData.append(UIImageJPEGRepresentation(image, 1)!)
//            } else {
//                formData.append((MPboundary + ENTER).data(using: String.Encoding.utf8)!)
//                formData.append("Content-Disposition: form-data; name=\"\(value.key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
//                formData.append((value.key as String + ENTER).data(using: String.Encoding.utf8)!)
//            }
//        }
//
//        formData.append((ENTER + endMPboundary).data(using: String.Encoding.utf8)!)
//
//        return formData as Data
//    }
    
    /// 上传图片参数 - request
//    func queryContentType() -> String {
//        return "multipart/form-data; boundary=WebKitFormBoundaryrGKCBY7qhFd3TrwA"
//    }
}
