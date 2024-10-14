//
//  TCellTextView.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TCellTextView: BaseTCell,UITextViewDelegate {
    
    var title: String = "" {
        didSet {
            textView.text = title
        }
    }
    var placeholder: String = "Please input strings" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    /// lazy loading - private variable
    private lazy var textView: UITextView = {
        let view = UITextView.init()
        view.font = UIFont.systemFont(ofSize: 16)
        view.delegate = self
        return view
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel.init()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.lightGray
        label.text = placeholder
        return label
    }()
    
    override func setupSubViews() {
        
        addSubview(textView)
        addSubview(placeholderLabel)
        setupLayouts()
    }
    
    override func setupLayouts() {
        
        textView.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.right.bottom.equalTo(-10)
        }
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(18)
            make.height.equalTo(20)
        }
    }
    
    override func height() -> CGFloat {
        return TCellTextView.classCellHeight()
    }
    
    override class func classCellHeight() -> CGFloat {
        return 200.0
    }
    
    func textViewDidChange(_ textView: UITextView) {
        title = textView.text
        
        if (title.count == 0) {
            placeholderLabel.alpha = 1.0
        } else {
            placeholderLabel.alpha = 0.0
        }
    }
    
    func beginInput() -> Void {
        textView.becomeFirstResponder()
    }
    
    func endInput() -> Void {
        textView.resignFirstResponder()
    }
}
