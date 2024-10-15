//
//  TCellInput.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TCellInput: BaseTCell,UITextFieldDelegate {
    /// attribute
    var icon: UIImage? = nil {
        didSet {
            iconView.image = icon
        }
    }
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var titleColor: UIColor = .gray {
        didSet {
            self.titleLabel.textColor = titleColor
        }
    }
    var value: String = "" {
        didSet {
            textField.text = value
        }
    }
    var placeholder: String = "Please input strings" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    /// lazy loading - private variable
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = titleColor
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var textField: UITextField = {
        let view = UITextField.init()
        view.font = .systemFont(ofSize: 15)
        view.delegate = self
        return view
    }()
    
    class func stringInputCell() -> BaseTCell {
        let inputCell = TCellInput.init(style: .default, reuseIdentifier: nil);
        inputCell.textField.keyboardType = .default;
        return inputCell;
    }
    class func numberInputCell() -> BaseTCell {
        let inputCell = TCellInput.init(style: .default, reuseIdentifier: nil);
        inputCell.textField.keyboardType = .numberPad;
        return inputCell;
    }
    class func passwordInputCell() -> BaseTCell {
        let inputCell = TCellInput.init(style: .default, reuseIdentifier: nil);
        inputCell.textField.keyboardType = .asciiCapable;
        inputCell.textField.isSecureTextEntry = true
        return inputCell;
    }
    
    override func setupSubViews() {
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        
        setupLayouts()
        //?
//        NotificationCenter.default.addObserver(self, selector: #selector(textFiledEditChanged), name: NSNotification.Name.UITextField.textDidChangeNotification, object: textField)
    }
    
    override func setupLayouts() {
        
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.left.equalTo(10)
            make.centerY.equalTo(self.snp.centerY)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.width.equalTo(70)
        }
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(-30)
            make.left.equalTo(titleLabel.snp.right).offset(10)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFiledEditChanged() -> Void {
        value = textField.text!
    }
    
    override func height() -> CGFloat {
        return TCellInput.classCellHeight()
    }
    
    override class func classCellHeight() -> CGFloat {
        return 50.0
    }
}
