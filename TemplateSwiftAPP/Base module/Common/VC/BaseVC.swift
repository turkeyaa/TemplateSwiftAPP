//
//  BaseVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit
import ProgressHUD

class BaseVC: UIViewController {
    
    var isHideNav: Bool = false
    
    var isShowEmptyView: Bool = false {
        didSet {
            if isShowEmptyView == true {
                view.addSubview(emptyView)
                view.bringSubviewToFront(emptyView)
            }
            else {
                emptyView.removeFromSuperview()
            }
        }
    }
    
    lazy var emptyView: EmptyView = {
        var view = EmptyView.init(frame: CGRect.init(x: 0, y: 0, width: Device_width, height: Device_height))
        view.emptyViewType = EmptyViewType.EmptyViewType_NoNavAndTab
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(emptyTapGesture))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var leftBtn: UIButton = {
        var view = UIButton.init(type: .custom)
        view.addTarget(self, action: #selector(BaseVC.goBack), for: .touchUpInside)
        view.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        view.titleLabel?.font = FontMacro.font15
        view.setTitleColor(ColorMacro.ColorNavTitle, for: .normal)
        return view
    }()
    
    private lazy var rightBtn: UIButton = {
        var view = UIButton.init(type: .custom)
        view.addTarget(self, action: #selector(BaseVC.goNext), for: .touchUpInside)
        view.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        view.titleLabel?.font = FontMacro.font15
        view.setTitleColor(ColorMacro.ColorNavTitle, for: .normal)
        return view
    }()
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorMacro.ColorBg
        self.edgesForExtendedLayout = UIRectEdge.top
        
        // todo
//        self.view.layer.borderWidth = 2
//        self.view.layer.borderColor = UIColor.blue.cgColor
    }
    
    // todo - 无效
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isHideNav {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    /// MARK: - Event
    @objc func goNext() -> Void {}
    @objc func goBack() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// MARK: - UI
    func leftTitle(title: String) -> Void {
        leftBtn.setTitle(title, for: .normal)
        let rightBarItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = rightBarItem
    }
    
    func rightTitle(title: String) -> Void {
        rightBtn.setTitle(title, for: .normal)
        let rightBarItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func leftIcon(icon: UIImage) -> Void {
        leftBtn.setImage(icon, for: .normal)
        let leftBarItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    func rightIcon(icon: UIImage) -> Void {
        rightBtn.setImage(icon, for: .normal)
        let rightBarItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    /// MARK: - SVProgressHUD
    func showLoadingHUD() -> Void {
        self.showLoadingHUD(hud: "LOADING")
    }
    
    func showLoadingHUD(hud: String) -> Void {
        self.settingSVProgressHUD()
        ProgressHUD.succeed(hud, delay: 1.5)
    }
    
    func hideLoadingHUD() -> Void {
        ProgressHUD.dismiss()
    }
    
    func showInfoMessage(hud: String) -> Void {
        self.settingSVProgressHUD()
        ProgressHUD.succeed(hud, delay: 1.5)
    }
    
    func showSuccessMessage(hud: String) -> Void {
        self.settingSVProgressHUD()
        ProgressHUD.succeed(hud, delay: 1.5)
    }
    
    func showErrorMessage(hud: String) -> Void {
        self.settingSVProgressHUD()
        ProgressHUD.failed(hud)
    }
    
    func settingSVProgressHUD() -> Void {
        ProgressHUD.colorHUD = .systemGray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// handle for empty view
    @objc func emptyTapGesture() -> Void {}
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
