//
//  JSONModel.swift
//  TemplateSwiftAPP
//
//  Created by wenhua yu on 2018/3/21.
//  Copyright © 2018年 wenhua yu. All rights reserved.
//

import Foundation

/// 实现自动化归档 - 需要子类继承
class JSONModel: NSObject,NSCoding {
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override init() {
        super.init()
    }
    
    // 解档
    required init?(coder aDecoder: NSCoder) {
        // 先初始化
        super.init()
        // 获取当前类的所有属性名
        let nameList = getPropertyNameList()
        // 进行解档
        for key in nameList {
            let value = aDecoder.decodeObject(forKey: key)
            setValue(value, forKey: key)
        }
    }
    
    // 归档
    func encode(with aCoder: NSCoder) {
        // 获取当前类的所有属性名
        let nameList = getPropertyNameList()
        // 进行归档
        for key in nameList {
            // KVC 取值
            if let value = value(forKey: key) {
                aCoder.encode(value, forKey: key)
            }
        }
    }
    
    func getPropertyNameList() -> [String] {
        //保存属性的个数
        var outCount : UInt32 = 0
        //保存属性名称的数组
        var list : [String] = []
        
        //获取属性集合
        let property = class_copyPropertyList(type(of:self), &outCount)
        //解包
        guard let propertyList = property else {
            return list
        }
        
        for i in 0 ..< Int(outCount){
            //取出单个属性
            let property = propertyList[i]
            
            //获取属性的名字
            let char_f = property_getName(property)
            //转换为String
            if let key = NSString(cString: char_f, encoding: String.Encoding.utf8.rawValue) as String? {
                //添加到数组
                list.append(key)
            }
        }
        return list
    }
}
