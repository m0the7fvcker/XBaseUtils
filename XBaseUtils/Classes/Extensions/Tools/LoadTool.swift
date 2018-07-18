//
//  LoadTool.swift
//  XBaseUtils
//
//  Created by Poly.ma on 2018/7/18.
//

import Foundation


/// 自定义awake()方法，代替+load()，需要实现OC load方法中的代码的功能可以
/// 实现 SelfAwake 协议中的方法然后添加代码
///
protocol SelfAwake: class {
    static func awake()
}


class NothingToSeeHere {
    
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAwake.Type)?.awake()
        }
        types.deallocate()
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIApplication {
    
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}

