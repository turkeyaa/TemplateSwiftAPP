//
//  Extension.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 颜色扩展
extension UIColor {
    class func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
    
    class func rgba(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
        return color
    }
}

// MARK: - 图片扩展
extension UIImage {
    class func contentOfURL(link: String) -> UIImage {
        let url = URL.init(string: link)!
        var image = UIImage()
        do {
            let data = try Data.init(contentsOf: url)
            image = UIImage.init(data: data)!
        } catch {
            print("Error downloading images")
        }
        return image
    }
}
