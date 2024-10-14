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

/** upload file base class
 */

class BaseUploadApi: BaseRestApi {
    
    override init(url: String, httpMethod: HttpMethods) {
        super.init(url: url, httpMethod: httpMethod)
        decodeType = .DecodeJSONTypeString;             // 图片路径
    }
    
    
    override func call(async: Bool) {

        // todo
        /*
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
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: _url, headers: ["Authorization":self.configToken()], encodingCompletion: { (encodingResult) in

            switch encodingResult {

                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        let result = response.result.value as! [String: Any]
                        let data = try? JSONSerialization.data(withJSONObject: result)
                        super.onSuccessed(response: data!)
                    }
                case .failure(let encodingError):
                    super.onError(error: encodingError)
            }
        })
        */
    }
    
//    override func call(async: Bool) {
//
//        if Thread.isMainThread {
//            assert(false, "主线程不允许同步调用")
//            return
//        }
//
//        var request: URLRequest = URLRequest(url: URL.init(string: _url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
//        request.httpMethod = "POST"
//
//        let formData = self.queryPostData()
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
//        /*
//        var body = Data.init()
//        let boundary = "WebKitFormBoundaryrGKCBY7qhFd3TrwA"
//        let filename = "image.png"
//        let file: Data = UIImagePNGRepresentation(UIImage.init(named: "app_weibo")!)!
//
//        body.append("\r\n--\(boundary)\r\n")
//        body.append("Content-Disposition: form-data; name=\"type\"\"\r\n\r\n")
//        body.append("iOS")
//        body.append("\r\n--\(boundary)\r\n")
//        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n\r\n")
//        body.append(file)
//        body.append("\r\n--\(boundary)--")
//
//        return body
//        */
//
//        var formData = Data.init()
//
//        let requestData = self.prepareRequestData()
//
//        for value in requestData {
//            if let image = value.value as? UIImage {
//                /// 图片
//                formData.append(ENTER + MPboundary + ENTER)
//                formData.append("Content-Disposition: form-data; name=\"\(value.key)\"; filename=\"image.png\"\r\n\r\n")
//                formData.append(UIImageJPEGRepresentation(image, 1)!)
//                formData.append(ENTER + endMPboundary)
//            } else {
//                formData.append(ENTER + MPboundary + ENTER)
//                formData.append("Content-Disposition: form-data; name=\"\(value.key)\"\r\n\r\n")
//                formData.append(value.key as String)
//                formData.append(ENTER)
//            }
//        }
//        formData.append((ENTER + endMPboundary).data(using: .utf8)!)
//        return formData as Data
//    }
    
    /// 上传图片参数 - request
    func queryContentType() -> String {
        return "multipart/form-data; boundary=WebKitFormBoundaryrGKCBY7qhFd3TrwA"
    }
}
