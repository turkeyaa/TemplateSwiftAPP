//
//  MineVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/8/29.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

class MineVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rightTitle(title: "归档")
    }
    
    override func goNext() {
        
        /// 路径
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let fileName = NSStringFromClass(self.classForCoder) as String
        
        let savePath = filePath + "/" + fileName + ".plist"
        
        // 归档
        let user = WorkSpace.currentUser()
        let rs = NSKeyedArchiver.archiveRootObject(user, toFile: savePath);
        print("rs = \(rs)")
        
        // 解档
        let localUser = NSKeyedUnarchiver.unarchiveObject(withFile: savePath) as! User;
        print("new : \(String(describing: localUser.nickName))")
    }
    
}
