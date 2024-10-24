//
//  RestApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import Alamofire

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

// todo for test
let ifAlamofireRequest = true

/// 接口对象基类
class RestApi {
    
    var _url: String = ""
    var _httpMethod: HttpMethods = .HttpMethods_Get     // default
    var _isCancel = false
    
    let timeout: TimeInterval = 10                      // time-out limit
    
    var task: URLSessionTask?
    
    // 2. init
    init(url: String, httpMethod: HttpMethods) {
        _url = url
        _httpMethod = httpMethod
        _isCancel = false
    }
    
    // todo test online api
    func call(asynchronous: Bool) -> Void {
        
        if ifAlamofireRequest == true {
            
            let condition = NSCondition.init()
            
            AF.request(_url).response { resp in
                debugPrint(resp)
                
                if let response = resp.response {
                    
                    if response.statusCode == 200 {
                    
                        self.onSuccessed(response: resp.data!)
                    } else {
                        self.onFailed(error: resp.error)
                    }
                }
                
                condition.lock()
                condition.signal()
                condition.unlock()
            }
            
            condition.lock()
            condition.wait()
            condition.unlock()
        }
        else {
            
            if Thread.isMainThread {
                assert(false, "can't fetch data in main thread")
                return
            }
            
            var request: URLRequest?
            
            if _httpMethod == .HttpMethods_Get {
                
                var strUrl: String = _url
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
                request = URLRequest(url: URL.init(string: _url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeout)
                request?.httpMethod = "POST"
                request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request?.httpBody = self.queryPostData()
            }
            else if _httpMethod == .HttpMethods_File {
                assert(false, "subclasses must overwrite:\(_httpMethod)")
            }
            else {
                assert(false, "todo other http methods:\(_httpMethod)")
            }
            
            // custom header - token
            request?.setValue(self.configToken(), forHTTPHeaderField: "Authorization")
            
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
    }
    
    
    func cancel() -> Void {
        task!.cancel()
    }
    
    // 4. parameter
    func queryPostData() -> Data? {
        return nil
    }
    func queryParameters() -> Dictionary<String, Any>? {
        return nil
    }
    func queryFileParameters() -> Dictionary<String, Any> {
        return [:]
    }
    
    // 5. custom header
    func configToken() -> String {
        return "Bearer " + queryToken()
    }
    
    func queryToken() -> String {
        return ""
    }
    
    // TODO: log
    // 6. callback，subclasses need overwrite these methods
    func onSuccessed(response: Data) -> Void {}
    func onFailed(error: Error?) -> Void {}
    func onCancelled() -> Void {}
    func onTimeout() -> Void {}
    func onError(error: Error) -> Void {}
}
