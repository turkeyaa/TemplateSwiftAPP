//
//  RestApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

/** 基于NSURLSession的HTTP数据交互实现，你也可以通过第三方库来实现.
 */

// 1. 定义枚举
enum HttpMethods {
    case HttpMethods_Get
    case HttpMethods_Post
    case HttpMethods_Delete
    case HttpMethods_Put
    case HttpMethods_File
}

/// 接口对象基类
class RestApi {
    
    var _url: String?
    var _httpMethod: HttpMethods = .HttpMethods_Get     // 默认为GET请求
    var _isCancel = false
    
    let timeout: TimeInterval = 20                      // 设置超时时间
    
    var task: URLSessionTask?
    
    // 2. 初始化
    init(url: String, httpMethod: HttpMethods) {
        _url = url
        _httpMethod = httpMethod
        _isCancel = false
    }
    
    // 3. 执行和取消
    func call(async: Bool) -> Void {
        
        if Thread.isMainThread {
            assert(false, "主线程不允许同步调用")
            return
        }
        
        var request: URLRequest?
        
        if _httpMethod == .HttpMethods_Get {
            
            var strUrl: String = _url!
            let params = self.queryParameters()
            
            if params != nil {
                var index = 0
                for (key, value) in params! {
                    if index == 0 {
                        strUrl.append("?")
                    }
                    else {
                        strUrl.append("&")
                    }
                    strUrl += key
                    strUrl += "="
                    strUrl += value as! String
                    
                    index += 1
                }
            }
            
            request = URLRequest(url: URL.init(string: strUrl)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
            request?.httpMethod = "GET"
        }
        else if _httpMethod == .HttpMethods_Post {
            request = URLRequest(url: URL.init(string: _url!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
            request?.httpMethod = "POST"
            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request?.httpBody = self.queryPostData()
        }
        else if _httpMethod == .HttpMethods_File {
            assert(false, "TODO - 暂未完成上传图片功能")
        }
        else {
            assert(false, "暂时不支持该请求:\(_httpMethod)")
        }
        
        /// 自定义header - token
        request?.addValue(self.configToken(), forHTTPHeaderField: "Authorization")
        
        let condition = NSCondition.init()
        
        let session: URLSession = URLSession.shared
        
        task = session.dataTask(with: request!, completionHandler: { (data, resp, error) in
            
            if error != nil {
                print(error.debugDescription)
                self.onError(error: error!)
            }
            else {
                if let response = resp as? HTTPURLResponse {
                    
                    if response.statusCode == 200 {
                        
                        self.onSuccessed(response: data!)
                    } else {
                        //通知UI接口执行失败
                        self.onFailed(error: error)
                    }
                }
            }
            
            condition.lock()
            condition.signal()
            condition.unlock()
            
        }) as URLSessionTask?
        
        task!.resume()
        
        condition.lock()
        condition.wait()
        condition.unlock()
    }
    func cancel() -> Void {
        task!.cancel()
    }
    
    // 4. 请求参数
    func queryPostData() -> Data? {
        return nil
    }
    func queryParameters() -> Dictionary<String, Any>? {
        return nil
    }
    
    /// 5. 自定义header
    func configToken() -> String {
        return "Bearer " + self.queryToken()
    }
    
    func queryToken() -> String {
        return ""
    }
    
    // TODO: 写入日志
    // 6. 回调，需要子类重写的方法
    func onSuccessed(response: Data) -> Void {}
    func onFailed(error: Error?) -> Void {}
    func onCancelled() -> Void {}
    func onTimeout() -> Void {}
    func onError(error: Error) -> Void {}
}
