//
//  UIImage+Extension.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/9.
//

import Foundation

extension UIImage {
    
    ///根据View生成图片
    public convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.bounds.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
    
    ///根据颜色生成图片
    public convenience init(color: UIColor, rect: CGRect) {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
}

extension UIImage {
    
    ///压缩图片
    public func compressImage(quality: CGFloat = 0.5) -> Data? {
        return UIImageJPEGRepresentation(self, quality)
    }
    
    ///绘制成制定大小
    public func scaleTo(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        return newImage
    }
    
    
}
