//
//  Information.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/4/10.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

class InformationVC: BaseFormGroupTC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupDataSource = [["cell","cell group","pull to refresh and load more","web view","empty view","Markdown view"],["local storage"],["auth","map","pay"]]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupDataSource.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let titles = groupDataSource[section]
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "UICell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        let titles = groupDataSource[indexPath.section]
        let title = titles[indexPath.row] as? String
        cell?.textLabel?.text = title
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        let titles = groupDataSource[indexPath.section]
        let title = titles[indexPath.row] as? String
        
        if section == 0 {
            switch row {
            case 0:
                do {
                    let vc = FormTableVC()
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case 1:
                do {
                    let vc = FormGroupTableVC()
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case 2:
                do {
                    let vc = AutoRefreshTableVC()
                    vc.hidesBottomBarWhenPushed = true
                    vc.title = title
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case 3:
                do {
                    let vc = WebVC()
                    vc.hidesBottomBarWhenPushed = true
                    vc.title = title
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case 4:
                do {
                    let vc = EmptyVC()
                    vc.hidesBottomBarWhenPushed = true
                    vc.title = title
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case 5:
                do {
                    let vc = CustomMarkdownVC()
                    vc.title = title
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            default:
                showInfoMessage(hud: "TODO - \(title ?? "") - not complete")
            }
        }
        else if section == 1 {
            showInfoMessage(hud: "TODO - \(title ?? "") - not complete")
        } else {
            showInfoMessage(hud: "TODO - \(title ?? "") - not complete")
        }
    }
}
