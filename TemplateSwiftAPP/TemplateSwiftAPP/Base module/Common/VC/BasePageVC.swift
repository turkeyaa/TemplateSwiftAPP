//
//  BasePageVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/12.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
import PageController

/// todo - 待优化
class BasePageVC: BaseVC {
    
    private var titles = [String]()
    private var controllers = [UIViewController]()

    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titles = self.configTitles()
        controllers = self.configControlles()
        
        configu()
        configuGesture()
    }
    
    private func exChangeTopViewIndex(index: Int) -> Void {
        self.view.bringSubview(toFront: controllers[index].view)
    }
    
    func configu() -> Void {
        for vc in controllers {
            self.addChildViewController(vc)
            self.view.addSubview(vc.view)
        }
        exChangeTopViewIndex(index: currentIndex)
    }
    
    func configuGesture() -> Void {
        let swipeLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeLeftEvent))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeRightEvent))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func swipeLeftEvent() -> Void {
        currentIndex = currentIndex + 1
        if currentIndex > controllers.count - 1 {
            currentIndex = controllers.count - 1
            return
        }
        exChangeTopViewIndex(index: currentIndex)
    }
    
    @objc func swipeRightEvent() -> Void {
        currentIndex = currentIndex - 1
        if currentIndex < 0 {
            currentIndex = 0
            return
        }
        exChangeTopViewIndex(index: currentIndex)
    }
    
    func configTitles() -> [String] {
        return [String]()
    }
    
    func configControlles() -> [UIViewController] {
        return [UIViewController]()
    }
}
