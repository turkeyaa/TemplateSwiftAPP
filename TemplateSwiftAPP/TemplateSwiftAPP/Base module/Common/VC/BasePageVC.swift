//
//  BasePageVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/12.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

/// todo - 待优化
class BasePageVC: BaseVC {
    
    private var titles = [String]()
    private var controllers = [UIViewController]()

    private var currentIndex: Int = 0
    
    lazy var titleIndexView: TitleIndexView = {
        
        var pointY = Device_status
        if !self.isHideNav {
            pointY += Device_nav
        }
        let view = TitleIndexView.init(titles: titles, frame: CGRect.init(x: 0, y: pointY, width: Device_width, height: 50))
        view.clickItemBlock = { (index: Int) -> Void in
            self.currentIndex = index
            self.exChangeTopViewIndex(index: index, type: true)
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titles = self.configTitles()
        controllers = self.configControlles()
        
        self.view.addSubview(titleIndexView)
        titleIndexView.updateUI()
        
        configu()
        configuGesture()
    }
    
    private func exChangeTopViewIndex(index: Int, type: Bool) -> Void {
        
        let view = controllers[index].view!
        self.view.bringSubview(toFront: view)
        
        if type {
            view.frame = CGRect.init(x: Device_height, y: view.frame.origin.y, width: Device_width, height: view.frame.size.height)
            UIView.animate(withDuration: 0.3) {
                view.frame = CGRect.init(x: 0, y: view.frame.origin.y, width: Device_width, height: view.frame.size.height)
            }
        } else {
            view.frame = CGRect.init(x: -Device_height, y: view.frame.origin.y, width: Device_width, height: view.frame.size.height)
            UIView.animate(withDuration: 0.3) {
                view.frame = CGRect.init(x: 0, y: view.frame.origin.y, width: Device_width, height: view.frame.size.height)
            }
        }
    }
    
    func configu() -> Void {
        for vc in controllers {
            self.addChildViewController(vc)
            vc.view.frame = CGRect.init(x: 0, y: titleIndexView.frame.size.height+titleIndexView.frame.origin.y, width: Device_width, height: self.view.frame.size.height-titleIndexView.frame.size.height-titleIndexView.frame.origin.y)
            self.view.addSubview(vc.view)
        }
        exChangeTopViewIndex(index: currentIndex, type: true)
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
        exChangeTopViewIndex(index: currentIndex, type: true)
        self.titleIndexView.currentIndex = currentIndex
    }
    
    @objc func swipeRightEvent() -> Void {
        currentIndex = currentIndex - 1
        if currentIndex < 0 {
            currentIndex = 0
            return
        }
        exChangeTopViewIndex(index: currentIndex, type: false)
        self.titleIndexView.currentIndex = currentIndex
    }
    
    func configTitles() -> [String] {
        return [String]()
    }
    
    func configControlles() -> [UIViewController] {
        return [UIViewController]()
    }
}
