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
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.isHideNav = true
        super.viewDidLoad()
    }
    
    // MAKR: - 加载数据
    override func queryData() -> Array<Any>? {
        
        let api = Topic_Get.init(offset: offset, limit: limit)
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
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 空页面点击交互
    @objc override func emptyTapGesture() -> Void {
        self.loadData(more: false)
    }
}
