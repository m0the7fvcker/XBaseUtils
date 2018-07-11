//
//  Dictionary+Extension.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/9.
//

import Foundation

extension Dictionary {
    
    ///添加字典
    public mutating func appendDicFrom(dic: Dictionary?) -> Dictionary {
        guard let otherDic = dic else {
            return self
        }
        for (key, value) in otherDic {
            self[key] = value
        }
        return self
    }
    
    ///Key是否存在
    public func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////

extension Dictionary {

    ///字典转JSON字符串
    public func jasonStirng(options: JSONSerialization.WritingOptions = []) -> String? {
        guard let jsonData = jasonData(options: options) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
    
    ///字典转Data
    public func jasonData(options: JSONSerialization.WritingOptions = []) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options)
        return jsonData
    }
}
