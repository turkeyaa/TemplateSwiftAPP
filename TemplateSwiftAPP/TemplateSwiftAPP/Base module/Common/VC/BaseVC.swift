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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    }
    
    
    // MARK: - Event
    @objc func goNext() -> Void {}
    @objc func goBack() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UI
    func leftTitle(title: String) -> Void {
        
        let leftBarItem = UIBarButtonItem.init(title: title, style: .done, target: self, action: #selector(BaseVC.goBack))
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    func rightTitle(title: String) -> Void {
        
//        let btn = UIButton.init(type: .system)
//        btn.setTitle(title, for: .normal)
//        btn.addTarget(self, action: #selector(BaseVC.goNext), for: .touchUpInside)
//        let rightBarView = UIBarButtonItem.init(customView: btn)
        
        let rightBarItem = UIBarButtonItem.init(title: title, style: .done, target: self, action: #selector(BaseVC.goNext))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    func leftIcon(icon: UIImage) -> Void {
        let leftBarItem = UIBarButtonItem.init(image: icon, style: .done, target: self, action: #selector(BaseVC.goBack))
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    func rightIcon(icon: UIImage) -> Void {
        let rightBarItem = UIBarButtonItem.init(image: icon, style: .done, target: self, action: #selector(BaseVC.goNext))
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    // MARK: - SVProgressHUD
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
        SVProgressHUD.setMinimumDismissTimeInterval(2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
