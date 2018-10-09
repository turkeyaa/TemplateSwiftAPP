//
//  CategoryDetailVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua on 2018/9/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class CategoryDetailVC: BaseLoadTC {
    
    var categoryId: Int = 1
    
    init(categoryId: Int) {
        self.categoryId = categoryId
        super.init()
        
        self.isHideNav = true
    }
    
    var parentNav: UINavigationController?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableViewFrame() -> CGRect {
        return CGRect.init(x: 0, y: 0, width: Device_width, height: self.view.frame.size.height-Device_tab-Device_status)
    }
    
    override func viewDidLoad() {
        self.isHideNav = true
        super.viewDidLoad()
        
        self.emptyView.emptyViewType = .EmptyViewType_Custom
        self.emptyView.customEmptyViewFrame(frame: CGRect.init(x: 0, y: self.view.frame.origin.y, width: Device_width, height: self.view.frame.size.height))
    }
    
    // MAKR: - 加载数据
    override func queryData() -> Array<Any>? {
        
        let api = CategoryTopic_Get.init(offset: offset, limit: limit, categoryId: categoryId)
        api.call(async: true)
        return api.dataSource
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TopicCell = TopicCell.tcell(tableView: tableView, reuse: true) as! TopicCell
        
        let topic = self.dataSource![indexPath.row] as! Topic
        cell.showIndicator(flag: true)
        cell.updateTopic(topic: topic)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        self.clickCell(index: indexPath.row)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TopicCell.classCellHeight()
    }
    
    // 点击 cell 事件
    func clickCell(index: Int) {
        
        let topic = self.dataSource![index] as! Topic
        
        let vc = TopicDetailVC()
        vc.topicID = topic.topicID!.uuidString
        vc.hidesBottomBarWhenPushed = true
        parentNav!.pushViewController(vc, animated: true)
    }
    
    /// 空页面点击交互
    @objc override func emptyTapGesture() -> Void {
        self.loadData(more: false)
    }
}
