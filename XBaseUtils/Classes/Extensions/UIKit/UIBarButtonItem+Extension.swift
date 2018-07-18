//
//  UIBarButtonItem+Extension.swift
//  XBaseUtils
//
//  Created by Poly.ma on 2018/7/18.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title: String? = "",
                 imageName: String? = "",
                 textColor: UIColor? = .black,
                      font: UIFont? = UIFont.systemFont(ofSize: 18),
                    target: AnyObject? = nil,
                    action: Selector? = nil) {
        
        let image = UIImage(named: imageName!)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: (image?.size.width)! * 1.5, height: (image?.size.height)! * 1.5))
        button.setImage(image, for: .normal)
        
        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        self.init(customView: button)
    }
}
