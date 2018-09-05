//
//  ActionHelper.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/5.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class ActionHelper: NSObject {
    
    /**
     *  自定义 SheetView
     *
     *  @param title          标题
     *  @param actions        操作
     *  @param vc             呈现的控制器
     *  @param clickItemBlock 回调
     */
    static func showSheet(title: String, message: String, actions: [String], vc: UIViewController, clickItemBlock: @escaping BlockItem) -> Void {
        
        let sheet = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        for index in 0..<actions.count {
            let action = UIAlertAction.init(title: actions[index], style: .default) { (alert) in
                clickItemBlock(index)
            }
            sheet.addAction(action)
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        sheet.addAction(cancelAction)
        vc.present(sheet, animated: true, completion: nil)
    }
    
    /**
     *  自定义 AlertView
     *
     *  @param title          标题
     *  @param message        内容
     *  @param actions        操作
     *  @param vc             呈现的控制器
     *  @param clickItemBlock 回调
     */
    static func showAlert(title: String, message: String, actions: [String], vc: UIViewController, clickItemBlock: @escaping BlockItem) -> Void {
        
        let sheet = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        for index in 0..<actions.count {
            let action = UIAlertAction.init(title: actions[index], style: .default) { (alert) in
                clickItemBlock(index)
            }
            sheet.addAction(action)
        }
        vc.present(sheet, animated: true, completion: nil)
    }
}
