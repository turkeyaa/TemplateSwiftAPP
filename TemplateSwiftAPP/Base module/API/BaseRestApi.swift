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

// 1. custom error type enum
enum RestApiCode: Int {
    
    case status_ok                  = 200
    case status_invalid_json        = 108          // encode JSON error
    case status_invalid_network     = 109          // Network is error
    case status_unkown_error        = 1001
    case status_token               = 1002
    case status_no_user             = 1003
    case status_error_psd           = 1004
    case status_existed_account     = 1005
    case status_no_entry            = 1006
    case status_error_params        = 1007
    
    // ...... other error type, keep the same in the server-side
}

// 2. MOCK API
enum MockType {
    case MockNone
    case MockFile
}

// 3. custom data type for parse
enum DecodeJSONType {
    case DecodeJSONTypeDictionary
    case DecodeJSONTypeArray
    case DecodeJSONTypeString
    case DecodeJSONTypeNone
}

class BaseRestApi: RestApi {
    
    var code: RestApiCode = .status_unkown_error
    var message: String = ""
    var errorMessage: String = ""
    
    var dataSource: [Any]?
    
    // default type
    var decodeType = DecodeJSONType.DecodeJSONTypeDictionary;
    
    static public func getRestApiURL(relativeURL: String) -> String {
        return URLHelper.sharedInstance.restApiURL(relativeURL: relativeURL)
    }
    
    override init(url: String, httpMethod: HttpMethods) {
        super.init(url: BaseRestApi.getRestApiURL(relativeURL: url),httpMethod: httpMethod)
    }
    
    override func call(async: Bool) {
        if self.mockType() == .MockNone {
            super.call(async: async)
        }
        else {
            // MOCK local api
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
    
    override func onFailed(error: Error?) {
        code = .status_invalid_network
        message = HUD_service_error
        GCDUtil.runInMainQueue {
            UIHelper.show(title: self.message)
        }
    }
    
    override func onError(error: Error) {
        code = .status_invalid_network
        message = HUD_network_error
        GCDUtil.runInMainQueue {
            UIHelper.show(title: self.message)
        }
    }
    
    override func onSuccessed(response: Data) -> Void {
        
        let responseJson = try! JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments)
        let responseDict = responseJson as! Dictionary<String, Any>
        
        print("RestApi:[\(self)]")
        print("RestApi Response:\(responseJson)")
        
        let data:Any? = responseDict["data"]
        message = responseDict["message"] as! String
        code = RestApiCode(rawValue: responseDict["status"] as! Int)!
        var resultData: Data?
        if decodeType == .DecodeJSONTypeString {
            if data != nil {
                resultData =  (data! as! String).data(using: .utf8)
            } else {
                resultData = Data.init()
            }
        } else if decodeType == .DecodeJSONTypeNone {
            resultData = Data.init()
        } else {
            if data != nil {
                resultData = try? JSONSerialization.data(withJSONObject: data ?? "", options: .prettyPrinted)
            } else {
                resultData = Data.init()
            }
        }
        
        if self.parseResponseJsonString(json: resultData!) {
            code = .status_ok
        }
        else {
            code = .status_invalid_json
        }
        
        super.onSuccessed(response: response)
    }
    
    // Subclassing methods
    func parseResponseJsonString(json: Data) -> Bool {
        assert(false, "Subclass must overwrite the method")
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

