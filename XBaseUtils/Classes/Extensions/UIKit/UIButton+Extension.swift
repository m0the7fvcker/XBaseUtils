//
//  UIButton+Extension.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/10.
//

import UIKit

fileprivate var kUIButtonTimeIntervalEnableKey = "kUIButtonTimeIntervalEnableKey"
fileprivate var kUIButtonExpandTouchAreaKey    = "kUIButtonExpandTouc11111hAreaKey"

public struct UIButtonExpandArea {
    public var left: CGFloat
    public var right: CGFloat
    public var top: CGFloat
    public var bottom: CGFloat
    
    public init(left: CGFloat = 20, right: CGFloat = 20, top: CGFloat = 20, bottom: CGFloat = 20) {
        self.left = left
        self.right = right
        self.top = top
        self.bottom = bottom
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIButton {
    convenience init(frame: CGRect = .zero,
                     title: String,
                  fontSize: UIFont = .systemFont(ofSize: 18),
                   bgColor: UIColor = .white) {
        self.init(frame: frame)
        setTitle(title, for: .normal)
        backgroundColor = bgColor
        titleLabel?.font = fontSize
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        self.setBackgroundImage(UIImage(color: color, rect: CGRect(x: 0, y: 0, width: 1, height: 1)), for: forState)
    }
    
    func setBackgroundColorAllState(color: UIColor) {
        self.setBackgroundColorStateTuple(colors: (normal: color, selected: color, highlighted: color))
    }
    
    func setBackgroundColorStateTuple(colors: (normal: UIColor, selected: UIColor, highlighted: UIColor)) {
        self.setBackgroundColor(color: colors.normal, forState: .normal)
        self.setBackgroundColor(color: colors.selected, forState: .selected)
        self.setBackgroundColor(color: colors.selected, forState: .highlighted)
    }
    
    func setTextColorAllState(color: UIColor) {
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color, for: .selected)
        self.setTitleColor(color, for: .highlighted)
    }
}

extension UIButton {
    
    /// 整体在中间 image在左 title在右
    ///
    /// - Parameters:
    ///   - imageWidth: imageWidth
    ///   - space: image和Button的间距
    public func setImageFrontTextWithCenterAlignment(imageWidth: CGFloat, space: CGFloat) {
        let image = imageView!.image!.scaleTo(size: CGSize(width: imageWidth, height: imageWidth))
        setImage(image, for: .normal)
        
        let insetAmount = space / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    /// 上下结构 image在上 label在下
    ///
    /// - Parameters:
    ///   - imageWidth: imageWidth
    ///   - space: space
    public func setImageFrontTextWithTopAlignment(imageWidth: CGFloat, space: CGFloat) {
        let image = imageView!.image!.scaleTo(size: CGSize(width: imageWidth, height: imageWidth))
        setImage(image, for: .normal)
        
        let titleLabelWidth = titleLabel?.text?.getTextWidth(font: (titleLabel?.font)!) ?? 0
        let labelHeight = CGFloat((titleLabel?.font.pointSize)!)
        
        imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space/2, left: 0, bottom: 0, right: -titleLabelWidth)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageWidth - space / 2, right: 0)
    }
}

extension UIButton {
    
    ///设置作用间隔时间
    public var enableTimeInterval: TimeInterval? {
        set {
            guard let timeInterval = newValue else {
                return
            }
            objc_setAssociatedObject(self, &kUIButtonTimeIntervalEnableKey, timeInterval, .OBJC_ASSOCIATION_ASSIGN)
            
            let sysMethod = class_getInstanceMethod(self.classForCoder, #selector(sendAction(_:to:for:)))
            let myMethod = class_getInstanceMethod(self.classForCoder, #selector(mSendAction(_:to:for:)))
            method_exchangeImplementations(sysMethod!, myMethod!)
        }
        get {
            return objc_getAssociatedObject(self, &kUIButtonTimeIntervalEnableKey) as? TimeInterval
        }
    }
    
    @objc func mSendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        isUserInteractionEnabled = false
        let time = enableTimeInterval ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.isUserInteractionEnabled = true
        }
        mSendAction(action, to: target, for: event)
    }
}

extension UIButton {
    
    ///扩展点击区域
    public var expandTouchArea: UIButtonExpandArea? {
        set {
            objc_setAssociatedObject(self, &kUIButtonExpandTouchAreaKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &kUIButtonExpandTouchAreaKey) as? UIButtonExpandArea
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let expandArea = expandTouchArea {
            return UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(-expandArea.top, -expandArea.left, -expandArea.bottom, -expandArea.right)).contains(point)
        }
        return super.point(inside: point, with: event)
    }
}
