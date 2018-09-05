//
//  AssetManager.swift
//  Pods-AssetPicker
//
//  Created by yuwenhua on 2017/10/3.
//

import Foundation
import UIKit
import Photos

open class AssetManager {
    
    // MARK: - 本地图片
    open static func getImage(_ name: String) -> UIImage {
        
        let traitCollection = UITraitCollection(displayScale: 3)
        var bundle = Bundle(for: AssetManager.self)
        
        if let resource = bundle.resourcePath, let resourceBundle = Bundle(path: resource + "TAssetPicker.bundle") {
            bundle = resourceBundle
        }
        
        return UIImage(named: name, in: bundle, compatibleWith: traitCollection) ?? UIImage()
    }
    
    // MARK: - 访问相册 - todo
    
    
}
