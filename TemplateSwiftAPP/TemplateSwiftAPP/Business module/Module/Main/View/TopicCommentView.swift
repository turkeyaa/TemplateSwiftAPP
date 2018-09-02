//
//  TopicCommentView.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TopicCommentView: UIView,UITextViewDelegate {
    
    var clickItemBlock: BlockItem?
    
    var title: String = "" {
        didSet {
            textView.text = title
        }
    }
    
    lazy var contentView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        return view
    }()
    lazy var closeBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("关闭", for: .normal)
        view.setTitleColor(UIColor.lightGray, for: .normal)
        view.addTarget(self, action: #selector(closeEvent), for: .touchUpInside)
        return view
    }()
    lazy var saveBtn: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("保存", for: .normal)
        view.setTitleColor(UIColor.orange, for: .normal)
        view.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        return view
    }()
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.init(white: 0.7, alpha: 0.3)
        return view
    }()
    lazy var textView: UITextView = {
        let view = UITextView.init()
        view.font = UIFont.systemFont(ofSize: 16)
        view.delegate = self
        return view
    }()
    
    init() {
        
        super.init(frame: CGRect.init(x: 0, y: 0, width: Device_width, height: Device_height))
        self.backgroundColor = UIColor.rgba(r: 0, g: 0, b: 0, alpha: 0.5)
        
        UIApplication.shared.keyWindow!.addSubview(self)
        addSubview(contentView)
        contentView.addSubview(closeBtn)
        contentView.addSubview(saveBtn)
        contentView.addSubview(lineView)
        contentView.addSubview(textView)
        
        setupLayout()
        
        show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() -> Void {
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(150)
            make.left.right.bottom.equalTo(0)
        }
        closeBtn.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.left.top.equalTo(10)
        }
        saveBtn.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.top.equalTo(10)
            make.right.equalTo(-10)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(39.5)
            make.height.equalTo(0.5)
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)      /// todo - 减去键盘高度
        }
    }
    
    @objc func closeEvent() -> Void {
        self.hide()
    }
    
    @objc func saveEvent() -> Void {
        if title.count == 0 {
            UIHelper.show(title: "评论内容不能为空")
            return
        }
        if clickItemBlock != nil {
            clickItemBlock!(1)
            hide()
        }
    }
    
    @objc func hide() -> Void {
//        UIView.animate(withDuration: 0.4, animations: {
//            self.contentView.frame = CGRect.init(x: 0, y: Device_height, width: Device_width, height: 0)
//        }) { (flag) in
//            if self.clickItemBlock != nil {
//                self.clickItemBlock!(0)
//            }
//        }
        textView.resignFirstResponder()
        UIView.animate(withDuration: 0.4) {
            self.frame = CGRect.init(x: 0, y: Device_height, width: Device_width, height: Device_height)
        }
    }
    
    func show() -> Void {
        UIView.animate(withDuration: 0.4) {
            self.frame = CGRect.init(x: 0, y: 0, width: Device_width, height: Device_height)
        }
        textView.becomeFirstResponder()
    }
    
    func beginInput() -> Void {
//        textView.becomeFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        title = textView.text
    }

}
