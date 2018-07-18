//
//  UIAlertController+Extension.swift
//  XBaseUtils
//
//  Created by Poly.ma on 2018/7/18.
//

import Foundation

extension UIAlertController {
    
    public func add(actions: UIAlertAction...) {
        for action in actions {
            addAction(action)
        }
    }
}
