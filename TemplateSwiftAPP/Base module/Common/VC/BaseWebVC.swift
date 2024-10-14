//
//  BaseWebVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import WebKit

class BaseWebVC: BaseVC,WKUIDelegate {
    
    
    var openURL: String = "" {
        didSet {
            setupLoad()
        }
    }
    
    var wkWebView: WKWebView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupWebView()
    }
    
    // 1. init WKWebView
    func setupWebView() -> Void {
    
        let config = WKWebViewConfiguration.init()
        config.preferences.minimumFontSize = 18.0
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        wkWebView = WKWebView.init(frame: view.bounds, configuration: config)
        view.addSubview(wkWebView!)
    }
    
    // 2. load web file
    func setupLoad() -> Void {
        
        let url = URL.init(string: openURL)
        let request = URLRequest.init(url: url!)
        wkWebView?.load(request)
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
