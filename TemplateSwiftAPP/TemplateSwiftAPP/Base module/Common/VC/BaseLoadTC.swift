//
//  BaseLoadTC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import MJRefresh

/** BaseLoadTC
 * 带有下拉刷新和上拉加载事件的UIViewController
 */
class BaseLoadTC: BaseTC {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView?.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refresh))
        self.tableView?.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMore))
        
        self.loadData(more: false)
    }
    
    
    // MARK: - 加载数据
    @objc func refresh() -> Void {
        print("下拉刷新")
        loadData(more: false)
    }
    @objc func loadMore() -> Void {
        print("加载更多")
        loadData(more: true)
    }
    func loadData(more: Bool) -> Void {
        self.showLoadingHUD()
        let queue = DispatchQueue.global()
        queue.async {
            
            let array = self.queryData()
            if more {
                self.dataSource = self.dataSource! + array
            }
            else {
                self.dataSource = array
            }
            
            DispatchQueue.main.async {
                self.hideLoadingHUD()
                self.tableView?.mj_footer.endRefreshing()
                self.tableView?.mj_header.endRefreshing()
                self.tableView?.reloadData()
            }
        }
    }
    
    // MARK: - 子类重写的方法
    func queryData() -> Array<Any> {
        return Array()
    }
}
