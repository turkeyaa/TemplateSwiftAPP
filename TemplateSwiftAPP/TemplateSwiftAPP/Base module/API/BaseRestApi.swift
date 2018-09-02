//
//  BaseRestApi.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

/** 接口请求基类(包含：GET/POST),上传文件查看基类:BaseUploadApi
 */

// 1. 定义枚举
enum RestApiCode: Int {
    case RestApi_OK = 0                 // 成功
    case RestApi_NoUserId = 0001        // 无用户ID信息(未登录)
    case RestApi_UnkownError = 0002     // 未知错误(系统出错)
    case RestApi_NoData      = 0003     // 没有数据
    case RestApi_InvalidJSON = 108      // 解析 JSON 异常
    
    // ...... 等其他错误码，和后台错误码保持一致即可
}

// 2. 模拟接口
enum MockType {
    case MockNone
    case MockFile
}

// 3. 定义解析数据类型
enum DecodeJSONType {
    case DecodeJSONTypeDictionary       // 结果为：字典对象
    case DecodeJSONTypeArray            // 结果为：数组对象
    case DecodeJSONTypeString           // 结果为：字符串对象
}

class BaseRestApi: RestApi {
    
    var code: RestApiCode = .RestApi_UnkownError
    var message: String = ""
    var errorMessage: String = ""
    
    var dataSource: [Any]?
    
    var decodeType = DecodeJSONType.DecodeJSONTypeDictionary;   // 默认值
    
    static public func getRestApiURL(relativeURL: String) -> String {
        return URLHelper.instance.restApiURL(relativeURL: relativeURL)
    }
    
    override init(url: String, httpMethod: HttpMethods) {
        super.init(url: BaseRestApi.getRestApiURL(relativeURL: url),httpMethod: httpMethod)
    }
    
    override func call(async: Bool) {
        if self.mockType() == .MockNone {
            super.call(async: async)
        }
        else {
            // 模拟本地接口
            let mockFile = self.mockFile()
            let fileUrl = Bundle.main.url(forResource: mockFile, withExtension: "json")!
            let data = try! Data.init(contentsOf: fileUrl)
            
            self.onSuccessed(response: data)
        }
    }
    
    override func queryPostData() -> Data? {
        let requestData = self.prepareRequestData()
        
        let json = try! JSONSerialization.data(withJSONObject: requestData, options: .prettyPrinted)
        
        return json
    }
    
    override func onSuccessed(response: Data) -> Void {
        
        let responseJson = try! JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments)
        let responseDict = responseJson as! Dictionary<String, Any>
        
        print("RestApi:[\(self)]")
        print("RestApi Response:\(responseJson)")
        
        let data:Any? = responseDict["data"]
        message = responseDict["message"] as! String
        
        var resultData: Data?
        if decodeType == .DecodeJSONTypeString {
            if data != nil {
                resultData =  (data! as! String).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            } else {
                resultData = Data.init()
            }
        } else {
            resultData = try? JSONSerialization.data(withJSONObject: data ?? "", options: .prettyPrinted)
        }
        
        if self.parseResponseJsonString(json: resultData!) {
            code = RestApiCode.RestApi_OK
        }
        else {
            code = RestApiCode.RestApi_InvalidJSON
        }
        
        super.onSuccessed(response: response)
    }
    
    // Subclassing methods
    func parseResponseJsonString(json: Data) -> Bool {
        assert(false, "子类必须重写该方法")
        return false
    }
    
    func prepareRequestData() -> Dictionary<String, Any> {
        let dic = [String: Any]()
        return dic
    }
    
    func mockType() -> MockType {
        return .MockNone
    }
    
    func mockFile() -> String {
        return ""
    }
}

