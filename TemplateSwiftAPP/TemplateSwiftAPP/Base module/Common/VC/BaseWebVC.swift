//
//  BaseWebVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import WebKit

class BaseWebVC: BaseVC,WKScriptMessageHandler {
    
    var openURL: String = ""
    
    var wkWebView: WKWebView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupWebView()
    }
    
    func setupWebView() -> Void {
        
        // 1. 初始化WKWebView
        let config = WKWebViewConfiguration.init()
        config.preferences.minimumFontSize = 18.0
        config.preferences.javaScriptEnabled = true
        wkWebView = WKWebView.init(frame: view.bounds, configuration: config)
        view.addSubview(wkWebView!)
        
        // 2. 读取资源文件
        if true {
            
            let url = Bundle.main.url(forResource: "citys", withExtension: "json")
            let request = URLRequest.init(url: url!)
            wkWebView?.load(request)
        }
        else {
            let url = URL.init(string: openURL)
            let request = URLRequest.init(url: url!)
            wkWebView?.load(request)
        }
        
        addUserScript()
        updateJS()
    }
    
    // MARK: - 注册协议,监听js事件
    func addUserScript() -> Void {
        let userCC = wkWebView?.configuration.userContentController
        userCC?.add(self, name: "collectionEvent")
    }
    // MARK: - 更新 js
    func updateJS() -> Void {
        let jsString = ""
        wkWebView?.evaluateJavaScript(jsString, completionHandler: { (obj, error) in
            
        })
    }
    
    
    // MARK: - js 调用原生接口
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print(message.body)
        
        if message.name == "collectionEvent" {
            self.showInfoMessage(hud: "收藏成功")
        }
        else if message.name == "" {
            
        }
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
