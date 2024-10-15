//
//  BaseMarkdownVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2024/10/15.
//  Copyright © 2024 wenhua yu. All rights reserved.
//

import Foundation
import MarkdownView
import UIKit


class BaseMarkdownVC: BaseVC {
    
    var mdFileName: String = "" {
        didSet {
            setupLoad()
        }
    }
    
    var mdFile: String = "" {
        didSet {
            setupLoad()
        }
    }
    
    
    lazy var mdView: MarkdownView = {
        
        let md = MarkdownView();
        md.frame = CGRect(x: 0, y: 0, width: Device_width, height: Device_height)
        md.isScrollEnabled = true
        
//        view.layer.borderColor = UIColor.red.cgColor
//        view.layer.borderWidth = 1.0
        
        return md
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMarkdownView()
    }
    
    // 1. init MarkdownView
    func setupMarkdownView() -> Void {
        
        self.view.addSubview(mdView)
    }
    
    func setupLoad() -> Void {
        
        if mdFileName != "" {
            let path = Bundle.main.path(forResource: mdFileName, ofType: "md")!
            let url = URL(fileURLWithPath: path)
            let markdown = try! String(contentsOf: url, encoding: String.Encoding.utf8)
            mdView.load(markdown: markdown, enableImage: true)
        } else if mdFile != "" {
            mdView.load(markdown: mdFile)
        } else {
            assert(false, "there is no data for loading")
        }
        
        mdView.onRendered = { [weak self] height in
            self?.view.setNeedsLayout()
        }
        // called when user touch link
        mdView.onTouchLink = { [weak self] request in
            guard let url = request.url else { return false }
            
            if url.scheme == "file" {
                return false
            } else if url.scheme == "https" {
                let webVC = WebVC()
                self?.navigationController?.pushViewController(webVC, animated: true)
                return false
            } else {
                return false
            }
        }
    }
    
}
