//
//  UIImageView+Extension.swift
//  XBaseUtils
//
//  Created by Poly.ma on 2018/7/18.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageWithUrlString(_ urlString: String?, placeHolder: String?) {
        let url = urlString ?? ""
        let image = placeHolder ?? ""
        
        if let urlString = URL(string: url) {
            self.kf.setImage(with: urlString, placeholder: UIImage(named: image))
        } else {
            self.image = UIImage(named: image)
        }
    }
}
