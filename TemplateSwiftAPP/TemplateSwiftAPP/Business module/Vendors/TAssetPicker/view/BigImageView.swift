//
//  BigImageView.swift
//  AssetPicker
//
//  Created by yuwenhua on 2017/10/2.
//  Copyright © 2017年 DS. All rights reserved.
//

import Foundation
import UIKit
class BigImageView: UIView,UIScrollViewDelegate {
    
    var images = [AssetInfo]() {
        willSet(newValue) {
            
        }
        didSet {
            updateUI()
        }
    }
    
    lazy var scrollerView: UIScrollView = {
        let scoller = UIScrollView.init(frame: self.bounds)
        scoller.isPagingEnabled = true
        scoller.delegate = self
        return scoller
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: TASDevice_height-40, width: TASDevice_width, height: 30))
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() -> Void {
        self.backgroundColor = UIColor.black
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(close))
        self.addGestureRecognizer(tap)
        
        addSubview(scrollerView)
        addSubview(titleLabel)
    }
    
    func updateUI() -> Void {
        
        for view in scrollerView.subviews {
            view.removeFromSuperview()
        }
        
        var index = 0
        for info in images {
            
            let image = info.image
            
            let imageView = UIImageView.init(image: image)
            imageView.frame = CGRect.init(x: CGFloat(index)*TASDevice_width, y: 0, width: TASDevice_width, height: TASDevice_height)
            imageView.contentMode = .scaleAspectFit
            scrollerView.addSubview(imageView)
            index=index+1
        }
        scrollerView.contentSize = CGSize.init(width: TASDevice_width*CGFloat(images.count), height: TASDevice_height)
        
        updateIndex()
    }
    
    func updateIndex() -> Void {
        let total = images.count
        let current = Int(scrollerView.contentOffset.x/TASDevice_width) + 1
        titleLabel.text = "\(current)"+"/"+"\(total)"
    }
    
    @objc func close() -> Void {
        self.removeFromSuperview()
    }
    
    // MARK: - UIScrollerView
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateIndex()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
