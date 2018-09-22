//
//  BaseVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import SVProgressHUD

class BaseVC: UIViewController {
    
    var isHideNav: Bool = false
    
    var isShowEmptyView: Bool = false {
        didSet {
            if isShowEmptyView == true {
                view.addSubview(emptyView)
                view.bringSubview(toFront: emptyView)
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
        view.titleLabel?.font = FontMacro.fontBB
        view.setTitleColor(ColorMacro.ColorText, for: .normal)
        return view
    }()
    
    private lazy var rightBtn: UIButton = {
        var view = UIButton.init(type: .custom)
        view.addTarget(self, action: #selector(BaseVC.goNext), for: .touchUpInside)
        view.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        view.titleLabel?.font = FontMacro.fontBB
        view.setTitleColor(ColorMacro.ColorText, for: .normal)
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorMacro.ColorBg
        self.edgesForExtendedLayout = UIRectEdge.top
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
        let rightBarItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    /// MARK: - SVProgressHUD
    func showLoadingHUD() -> Void {
        self.showLoadingHUD(hud: "正在加载")
    }
    
    func showLoadingHUD(hud: String) -> Void {
        self.settingSVProgressHUD()
        SVProgressHUD.show(withStatus: hud)
    }
    
    func hideLoadingHUD() -> Void {
        SVProgressHUD.dismiss()
    }
    
    func showInfoMessage(hud: String) -> Void {
        self.settingSVProgressHUD()
        SVProgressHUD.showInfo(withStatus: hud)
    }
    
    func showSuccessMessage(hud: String) -> Void {
        self.settingSVProgressHUD()
        SVProgressHUD.showSuccess(withStatus: hud)
    }
    
    func showErrorMessage(hud: String) -> Void {
        self.settingSVProgressHUD()
        SVProgressHUD.showError(withStatus: hud)
    }
    
    func settingSVProgressHUD() -> Void {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 空页面点击交互
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
