//
//  AssetPickerController.swift
//  AssetPicker
//
//  Created by yuwenhua on 2017/10/1.
//  Copyright © 2017年 DS. All rights reserved.
//


import Foundation
import UIKit
import Photos

let topHeight: CGFloat = 50.0

open class AssetPickerController: UIViewController {
    
    var images = [AssetInfo]()
    public var assetResult: TASAssetInfoBlock?
    public var errorResult: TASAssetErrorTypeBlock?
    
    var configuration: Configuration = Configuration.init()
    
    lazy var bigImageView: BigImageView = {
        let view: BigImageView = BigImageView.init(frame: self.view.bounds)
        return view
    }()
    
    lazy var assetView: AssetCollectionView = {
        let assetView : AssetCollectionView = AssetCollectionView.init(frame: CGRect.init(x: 0, y: TASDevice_status+topHeight, width: TASDevice_width, height: TASDevice_height-TASDevice_status-topHeight))
        assetView.maxCount = self.configuration.maxCount
        assetView.clickItemBlock = { (index: Int) in
            if (self.assetView.itemCount == 0) {
                self.topView.numberLabel.isHidden = true
            }
            else {
                self.topView.numberLabel.text = "\(self.assetView.itemCount)"
                self.topView.numberLabel.isHidden = false
            }
        }
        assetView.errorTypeBlock = errorResult
        return assetView
    }()
    
    lazy var topView: TopView = {
        
        let view: TopView = TopView.init(frame: CGRect.init(x: 0, y: TASDevice_status, width: TASDevice_width, height: topHeight),configu: self.configuration)
        view.clickItemBlock = { (index: Int) in
            if index == 0 {
                self.dismiss(animated: true, completion: nil)
            } else if index == 1 {
                if (self.assetResult != nil) {
                    var images = [UIImage]()
                    for info in self.assetView.selectImages {
                        images.append(info.image)
                    }
                    self.assetResult!(images)
                }
                self.dismiss(animated: true, completion: nil)
            } else {
                self.view.addSubview(self.bigImageView)
                self.bigImageView.images = self.assetView.selectImages
            }
        }
        return view
    }()
    
    public init(configu: Configuration) {
        self.configuration = configu
        super.init(nibName: nil, bundle: nil)
    }
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupUI()
        readAlbum()
    }
    
    func setupUI() -> Void {
        view.addSubview(topView)
        view.addSubview(assetView)
    }
    
    func getAssetThumbnail(asset:PHAsset) -> Void {
        
        //获取缩略图
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions() //可以设置图像的质量、版本、也会有参数控制图像的裁剪
        //返回一个单一结果，返回前会堵塞线程，默认是false
        option.isSynchronous = true
        option.deliveryMode = .highQualityFormat
        
        manager.requestImage(for: asset, targetSize: CGSize.init(width: 200, height: 400), contentMode: .aspectFit, options: option) { (thumbnailImage, info) in
            let info = AssetInfo.init()
            info.image = thumbnailImage!
            self.images.append(info)
        }
    }
    
    func readAlbum() -> Void {
        
        DispatchQueue.global().async {
            
            let smartAlbums: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
            for index in 0..<smartAlbums.count {
                // 获取一个相册
                let collection = smartAlbums[index]
                if collection.isKind(of: PHAssetCollection.classForCoder()) {
                    let assetCollection = collection
                    
                    let assetsFetchResults: PHFetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
                    assetsFetchResults.enumerateObjects({ (asset, i, nil) in
                        // 获取每一个资源(PHAsset)
                        self.getAssetThumbnail(asset: asset)
                    })
                }
            }
            
            DispatchQueue.main.async {
                if self.images.count > 0 {
                    self.assetView.images = self.images
                    self.assetView.reloadData()
                }
            }
        }
    }
}

