//
//  AssetCell.swift
//  TemplateSwift
//
//  Created by yuwenhua on 2017/10/1.
//  Copyright © 2017年 DS. All rights reserved.
//

import Foundation
import UIKit

class AssetCell: UICollectionViewCell {
    
    lazy var iconView : UIImageView = {
        var imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        return imageView
    }()
    
    lazy var selectView : UIImageView = {
        var imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.frame = CGRect.init(x: self.frame.size.width-25, y: 5, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconView)
        contentView.addSubview(selectView)
    }
    
    func updateSelect(select: Bool) -> Void {
        if select {
            selectView.image = AssetManager.getImage("select")
        }
        else {
            selectView.image = AssetManager.getImage("deselect")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
