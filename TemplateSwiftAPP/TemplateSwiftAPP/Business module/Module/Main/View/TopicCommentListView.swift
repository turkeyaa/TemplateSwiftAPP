//
//  TopicCommentListView.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/2.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class TopicCommentListView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    var clickItemBlock: BlockItem?
    
    var dataSource: Array<Any>?
    
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
    lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.init(white: 0.7, alpha: 0.3)
        return view
    }()
    lazy var tableView: UITableView = {
        let view = UITableView.init(frame: CGRect.zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    init() {
        
        super.init(frame: CGRect.init(x: 0, y: 0, width: Device_width, height: Device_height))
        self.backgroundColor = UIColor.rgba(r: 0, g: 0, b: 0, alpha: 0.5)
        
        UIApplication.shared.keyWindow!.addSubview(self)
        self.addSubview(contentView)
        contentView.addSubview(closeBtn)
        contentView.addSubview(lineView)
        contentView.addSubview(tableView)
        
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
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(39.5)
            make.height.equalTo(0.5)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.left.right.bottom.equalTo(0)
        }
    }
    
    @objc func closeEvent() -> Void {
        self.hide()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource != nil {
            return self.dataSource!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CommentCell = CommentCell.tcell(tableView: tableView, reuse: true) as! CommentCell
        
        let comment = self.dataSource![indexPath.row] as! Comment
        cell.showIndicator(flag: false)
        cell.updateComment(comment: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CommentCell.classCellHeight()
    }
    
    func reloadData() -> Void {
        tableView.reloadData()
    }
    
    @objc func hide() -> Void {
        UIView.animate(withDuration: 0.4) {
            self.frame = CGRect.init(x: 0, y: Device_height, width: Device_width, height: Device_height)
        }
    }
    
    func show() -> Void {
        UIView.animate(withDuration: 0.4) {
            self.frame = CGRect.init(x: 0, y: 0, width: Device_width, height: Device_height)
        }
    }
}
