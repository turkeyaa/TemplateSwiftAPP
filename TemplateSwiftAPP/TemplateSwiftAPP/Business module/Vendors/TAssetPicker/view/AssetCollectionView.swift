//
//  AssetCollectionView.swift
//  TemplateSwift
//
//  Created by yuwenhua on 2017/10/1.
//  Copyright © 2017年 DS. All rights reserved.
//

import Foundation
import UIKit

class AssetCollectionView: UIView {
    var images = [AssetInfo]()
    var selectImages = [AssetInfo]()
    var itemCount: Int = 0
    
    var clickItemBlock: TASAssetItemBlock?
    var errorTypeBlock: TASAssetErrorTypeBlock?
    
    var maxCount: Int = 1
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        layout.sectionInset = UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1)
        let width = self.frame.size.width
        layout.itemSize = CGSize.init(width: (width-5)/4, height: (width-5)/4)
        
        let collectionView : UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(AssetCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        addSubview(collectionView)
    }
    
    func reloadData() -> Void {
        collectionView.reloadData()
    }
}

extension AssetCollectionView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let info = self.images[indexPath.row]
        info.select = !info.select
        
        if (info.select && selectImages.count >= maxCount) {
            info.select = !info.select
            
            if errorTypeBlock != nil {
                errorTypeBlock!(0)
            }
            return
        }
        else {
            if info.select {
                selectImages.append(info)
                itemCount = itemCount+1
            } else {
                let index = selectImages.index(of: info)
                selectImages.remove(at: index!)
                itemCount = itemCount-1
            }
            // 刷新当前item
            collectionView.reloadItems(at: [indexPath])
            
            if clickItemBlock != nil {
                clickItemBlock!(0)
            }
        }
    }
}

extension AssetCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AssetCell
        let info = self.images[indexPath.item]
        cell.iconView.image = info.image
        cell.updateSelect(select: info.select)
        return cell
    }
}
