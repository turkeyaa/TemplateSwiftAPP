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
     *  Custom SheetView
     *
     *  @param title
     *  @param actions
     *  @param vc
     *  @param clickItemBlock
     */
    static func showSheet(title: String, message: String, actions: [String], vc: UIViewController, clickItemBlock: @escaping BlockItem) -> Void {
        
        let sheet = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        for index in 0..<actions.count {
            let action = UIAlertAction.init(title: actions[index], style: .default) { (alert) in
                clickItemBlock(index)
            }
            sheet.addAction(action)
        }
        let cancelAction = UIAlertAction.init(title: "cancel", style: .cancel, handler: nil)
        sheet.addAction(cancelAction)
        vc.present(sheet, animated: true, completion: nil)
    }
    
    /**
     *  custom AlertView
     *
     *  @param title
     *  @param message
     *  @param actions
     *  @param vc
     *  @param clickItemBlock
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
