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
    
    var offset: Int = 0
    var limit: Int = 10
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refresh))
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMore))
        
        self.loadData(more: false)
    }
    
    
    // MARK: - 加载数据
    @objc func refresh() -> Void {
        print("下拉刷新")
        offset = 0
        loadData(more: false)
    }
    
    @objc func loadMore() -> Void {
        print("加载更多")
        offset += 1
        loadData(more: true)
    }
    
    func loadData(more: Bool) -> Void {
        self.showLoadingHUD()
        let queue = DispatchQueue.global()
        queue.async {
            
            let array = self.queryData()
            if array != nil {
                if more {
                    self.dataSource = self.dataSource! + array!
                }
                else {
                    self.dataSource = array
                }
            } else {
                /// 网络链接失败了
            }
            
            DispatchQueue.main.async {
                self.hideLoadingHUD()
                self.tableView.mj_footer.endRefreshing()
                self.tableView.mj_header.endRefreshing()
                
                if self.dataSource == nil {
                    /// 网络链接失败了
//                    self.showErrorMessage(hud: "网络连接异常了")
                    self.isShowEmptyView = true
                } else {
                    self.isShowEmptyView = false
                    if ((self.limit+1) * self.offset) > self.dataSource!.count {
                        /// 暂无更多数据
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - 子类重写的方法
    func queryData() -> Array<Any>? {
        return nil
    }
}
