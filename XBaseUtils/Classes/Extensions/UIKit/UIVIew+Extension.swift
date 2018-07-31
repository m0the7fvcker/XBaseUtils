//
//  UIVIew+Extension.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/9.
//

import UIKit

fileprivate var kUIViewDimBackgroundView = "UIViewDimBackgroundView"
fileprivate let kUIViewModalTimeinterval: TimeInterval = 0.25

public enum UIViewGradientDirection : Int {
    case top                    //向上
    case bottom                 //向下
    case left                   //向左
    case right                  //向右
    case topLeftToBottomRight   //左上角到右下角
    case topRightToBottomLeft   //右上角到左下角
    case bottomLeftToTopRight   //左下角到右上角
    case bottomRightToTopLeft   //右下角到左上角
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIView {
    public var x: CGFloat {
        set {
            frame.origin.x = newValue
        }
        get {
            return frame.origin.x
        }
    }
    
    public var y: CGFloat {
        set {
            frame.origin.y = newValue
        }
        get {
            return frame.origin.y
        }
    }
    
    public var width: CGFloat {
        set {
            frame.size.width = newValue
        }
        get {
            return frame.size.width
        }
    }
    
    public var height: CGFloat {
        set {
            frame.size.height = newValue
        }
        get {
            return frame.size.height
        }
    }
    
    ///获取父控制器
    public func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIView {
    
    ///设置圆角
    public func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    ///设置边框
    public func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
}

extension UIView {
    
    fileprivate var dimBackgroundView: UIView? {
        set {
            objc_setAssociatedObject(self, &kUIViewDimBackgroundView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &kUIViewDimBackgroundView) as? UIView
        }
    }
    
    public func modalShowInView(_ view: UIView, animated: Bool) {
        frame.origin.y = view.frame.height
        
        let dimBgView = UIView(frame: view.bounds)
        dimBgView.backgroundColor = .black
        dimBgView.alpha = 0
        dimBackgroundView = dimBgView
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(dismissGestureAction(guesture:)))
        dimBgView.addGestureRecognizer(tapGuesture)
        
        view.addSubview(dimBgView)
        view.addSubview(self)
        
        let duration: TimeInterval = animated ? kUIViewModalTimeinterval : 0
        UIView.animate(withDuration: duration, animations: {
            self.frame.origin.y = view.frame.height - self.frame.height
            dimBgView.alpha = 0.5
        })
    }
    
    public func modalDismiss(animated: Bool) {
        guard dimBackgroundView?.superview != nil && superview != nil else { return }
        
        let duration: TimeInterval = animated ? kUIViewModalTimeinterval : 0
        UIView.animate(withDuration: duration, animations: {
            self.dimBackgroundView?.alpha = 0
            self.frame.origin.y = (self.superview?.frame.height)!
        }, completion: { (_) in
            self.dimBackgroundView?.removeFromSuperview()
            self.dimBackgroundView = nil
            self.removeFromSuperview()
        })
    }
    
    @objc private func dismissGestureAction(guesture: UITapGestureRecognizer) {
        modalDismiss(animated: true)
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIView {
    
    /// 添加渐变色层
    ///
    /// - Parameter colors: 给 cgcolor 数组
    public func addGradientLayer(colors: [UIColor]) {
        self.addGradientLayer(colors: colors, direction: .bottom)
    }
    
    public func addGradientLayer(colors: [UIColor], direction : UIViewGradientDirection){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map({ (color) -> CGColor in
            color.cgColor
        })
        gradientLayer.locations = [0.0, 1.0]
        
        switch direction {
        case .top:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .bottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .left:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .right:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .topRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .bottomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        case .bottomRightToTopLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    public func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat, strokeColor: UIColor? = nil) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        
        if strokeColor != nil {
            maskLayer.lineWidth = 0.5
            maskLayer.strokeColor = strokeColor?.cgColor
        }
        maskLayer.fillColor = UIColor.clear.cgColor
        self.layer.insertSublayer(maskLayer, at: 0)
    }
}
