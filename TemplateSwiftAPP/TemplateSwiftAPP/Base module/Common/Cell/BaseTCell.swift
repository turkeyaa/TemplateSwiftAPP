//
//  BaseTCell.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

/** UITableViewCell 基类
 */
class BaseTCell: UITableViewCell {
    
    var _commonInit = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func classCellHeight() -> CGFloat {
        return 44.0
    }
    
    class func tcell(tableView: UITableView?, reuse: Bool) -> BaseTCell {
        var cell: BaseTCell?
        if reuse && tableView != nil {
            let identifier = NSStringFromClass(self)
            cell = tableView!.dequeueReusableCell(withIdentifier: identifier) as? BaseTCell
            if cell == nil {
                
                cell = self.init(style: .default, reuseIdentifier: identifier)
            }
        }
        else {
            cell = self.init(style: .default, reuseIdentifier: nil)
        }
        return cell!
    }
    
    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func commonInit() -> Void {
        if _commonInit == false {
            _commonInit = true
            self.setupUI()
        }
    }
    
    func setupUI() -> Void {
        self.showIndicator(flag: true)
        
        self.setupSubViews()
    }
    
    // override
    func setupSubViews() -> Void {}
    func setupLayouts() -> Void {}
    
    func showIndicator(flag: Bool) -> Void {
        if flag {
            self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        else {
            self.accessoryType = UITableViewCellAccessoryType.none
        }
    }
    
    func height() -> CGFloat {
        return BaseTCell.classCellHeight()
    }
}
