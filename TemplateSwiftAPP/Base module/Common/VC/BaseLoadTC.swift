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
 * contain pull to refresh and Pull-up loading
 */
class BaseLoadTC: BaseTC {
    
    var offset: Int = 0
    var limit: Int = 10
    
//    override init() {
//        super.init()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.mj_header = MJRefreshHeader(refreshingTarget: self, refreshingAction: #selector(refresh))
        self.tableView.mj_footer = MJRefreshFooter(refreshingTarget: self, refreshingAction: #selector(loadMore))

        self.loadData(more: false)
    }
    
    
    // MARK: - LOADING
    @objc func refresh() -> Void {
        print("pull to refresh")
        offset = 0
        loadData(more: false)
    }
    
    @objc func loadMore() -> Void {
        print("load more")
        offset += 1
        loadData(more: true)
    }
    
    func loadData(more: Bool) -> Void {
        
        self.showLoadingHUD()
        
        GCDUtil.runInGlobalQueue {
            let array = self.queryData()
            if array != nil {
                if more {
                    self.dataSource = self.dataSource! + array!
                }
                else {
                    self.dataSource = array
                }
            } else {
                // todo network is error
            }
            
            GCDUtil.runInMainQueue {
                self.hideLoadingHUD()
                self.tableView.mj_footer?.endRefreshing()
                self.tableView.mj_header?.endRefreshing()
                
                if self.dataSource == nil {
                    self.showErrorMessage(hud: HUD_network_error)
                    self.isShowEmptyView = true
                } else if self.dataSource?.count == 0 {
                    // no data
                    self.isShowEmptyView = true
                } else {
                    self.isShowEmptyView = false
                    if ((self.limit+1) * self.offset) > self.dataSource!.count {
                        // no more data
                        self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                    }
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
//    func loadData(more: Bool) -> Void {
//        self.showLoadingHUD()
//        let queue = DispatchQueue.global()
//        queue.async {
//            
//            let array = self.queryData()
//            if array != nil {
//                if more {
//                    self.dataSource = self.dataSource! + array!
//                }
//                else {
//                    self.dataSource = array
//                }
//            } else {
//                // todo network is error
//            }
//            
//            DispatchQueue.main.async {
//                self.hideLoadingHUD()
//                self.tableView.mj_footer?.endRefreshing()
//                self.tableView.mj_header?.endRefreshing()
//                
//                if self.dataSource == nil {
//                    self.showErrorMessage(hud: HUD_network_error)
//                    self.isShowEmptyView = true
//                } else if self.dataSource?.count == 0 {
//                    // no data
//                    self.isShowEmptyView = true
//                } else {
//                    self.isShowEmptyView = false
//                    if ((self.limit+1) * self.offset) > self.dataSource!.count {
//                        // no more data
//                        self.tableView.mj_footer?.endRefreshingWithNoMoreData()
//                    }
//                }
//                
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    // MARK: -  mush perform the service logic in subclass
    func queryData() -> Array<Any>? {
        return nil
    }
}
