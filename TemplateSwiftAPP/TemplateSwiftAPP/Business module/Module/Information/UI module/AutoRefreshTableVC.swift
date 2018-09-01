//
//  AutoRefreshTableVC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/4/12.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class AutoRefreshTableVC: BaseLoadTC {
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    // MAKR: - 加载数据
    override func queryData() -> Array<Any> {
        
        let api = Topic_Get.init(offset: 1, limit: 10)
        api.call(async: true)
        /// 休眠1秒
        sleep(1)
        return api.dataSource!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TopicCell = TopicCell.tcell(tableView: tableView, reuse: true) as! TopicCell
        
        let topic = self.dataSource?[indexPath.row] as! Topic
        cell.showIndicator(flag: true)
        cell.updateTopic(topic: topic)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        let vc = TopicDetailVC()
        vc.topic = self.dataSource![indexPath.row] as! Topic
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TopicCell.classCellHeight()
    }
}
