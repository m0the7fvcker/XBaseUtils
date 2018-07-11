//
//  UILabel+Extension.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/9.
//

import UIKit

fileprivate let labelCopyAbleKey = "labelCopyAbleKey"

extension UILabel {
    public convenience init(title: String?,
                        titleFont: UIFont,
                            align: NSTextAlignment = .center,
                            color: UIColor = .black,
                     numberOfLine: Int = 1) {
        self.init()
        text = title
        textAlignment = align
        textColor = color
        font = titleFont
        numberOfLines = numberOfLine
    }
}

extension UILabel {
    
    ///是否能复制文本
    public var copyable: Bool? {
        get {
            return objc_getAssociatedObject(self, labelCopyAbleKey) as? Bool
        }
        set {
            objc_setAssociatedObject(self, labelCopyAbleKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            guard newValue == true else {
                return
            }
            addLongPressGuesture()
        }
    }
    
    ///添加长按手势
    private func addLongPressGuesture() {
        isUserInteractionEnabled = true
        let longPressGuesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressEvent(sender:)))
        addGestureRecognizer(longPressGuesture)
    }
    
    @objc func longPressEvent(sender: UILongPressGestureRecognizer) {
        becomeFirstResponder()
        
        let menu = UIMenuController.shared
        let copy = UIMenuItem(title: "复制", action: #selector(copyText))
        menu.menuItems = [copy]
        menu.setTargetRect(bounds, in: self)
        menu.setMenuVisible(true, animated: true)
    }
    
    @objc func copyText() {
        if text != nil {
            UIPasteboard.general.string = text
        }else {
            UIPasteboard.general.string = attributedText?.string
        }
    }
    
    open override var canBecomeFirstResponder: Bool {
        return true
    }
}
