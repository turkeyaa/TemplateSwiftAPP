//
//  BaseTC.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/28.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit


class BaseTC: BaseVC,UITableViewDelegate,UITableViewDataSource {
    
    
    var dataSource: Array<Any>?
    
    lazy var tableView: UITableView = {
        let view = UITableView.init(frame: tableViewFrame(), style: tableViewStyle())
        view.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Device_width, height: 10.0))
        view.tableFooterView = UIView.init()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
//    override init() {
//        super.init()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.addSubview(tableView)
    }
    
    // MARK: custom table view style
    func tableViewStyle() -> UITableView.Style {
        return UITableView.Style.plain
    }
    
    // MARK: custom table view frame
    func tableViewFrame() -> CGRect {
        return self.view.bounds
    }
    
    // MARK: - tableView delegate and dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataSource != nil {
            return dataSource!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BaseTCell.classCellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - parting line
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
