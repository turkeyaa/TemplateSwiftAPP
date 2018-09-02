//
//  FileManager.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

///  程序文件存储目录
///<>/Documents/
///<>/Library/Preferences/
///<>/Library/Caches/
///<>/tmp/

class SandFileManager {
    
    /// todo - 暂未完成
    /// 创建新目录
    private static func createDir(filePath: String) -> Void {
        
        if !FileManager.default.fileExists(atPath: filePath) {
            FileManager.default.createFile(atPath: filePath, contents: Data.init(base64Encoded: "Hello, world"), attributes: nil)
//            try? FileManager.default.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    ///<>/Documents/appPreference.plist
    /// 程序设置信息
    static func appPreferenceFile() -> String {
        
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let fileName = "appPreference.plist"
        let savePath = filePath + "/" + fileName
        self.createDir(filePath: savePath)
        return savePath
    }
    
    ///<>/Documents/Crash/crashLog.txt
    // 错误日志
    static func crashFile() -> String {
        
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let fileName = "crashLog.txt"
        let savePath = filePath + "/Crash/" + fileName
        self.createDir(filePath: savePath)
        return savePath
    }
    
    ///<>/Library/Preferences/user.plist
    // 程序设置信息
    static func userPreferenceFile() -> String {
        
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let fileName = "user.plist"
        let savePath = filePath + "/Preferences/" + fileName
        self.createDir(filePath: savePath)
        return savePath
    }
}
