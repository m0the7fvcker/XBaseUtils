//
//  Array+Extension.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/9.
//

import Foundation

extension Array where Element : Equatable {
    
    /// 删除重复元素
    public func removedDuplicates() -> [Element] {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
    
    /// 是否包含某元素
    public func contains(_ elements: [Element]) -> Bool {
        for item in elements {
            if contains(item) == false {
                return false
            }
        }
        return true
    }
}
