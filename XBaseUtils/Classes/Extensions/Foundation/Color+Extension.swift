//
//  Color+Extension.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/6.
//

import UIKit

private func hexToDec(hex : String) -> CGFloat {
    let str = hex.uppercased()
    var sum  = 0
    for c in str.utf8 {
        sum = sum * 16 + Int(c) - 48
        if c >= 65 {
            sum -= 7
        }
    }
    return CGFloat(sum) / 255.0
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIColor {
    
    /// 随机色
    public class func randomColor(randomAlpha: Bool = false) -> UIColor {
        let randomRed = arc4random() % 255
        let randomGreen = arc4random() % 255
        let randomBlue = arc4random() % 255
        let alpha = randomAlpha ? arc4random() % 255 : 1
        return UIColor(red: CGFloat(randomRed) / 225.0, green: CGFloat(randomGreen)/225.0, blue: CGFloat(randomBlue)/225.0, alpha: randomAlpha ? CGFloat(alpha) : 1)
    }
    
    /// 十六进制颜色
    public convenience init(hexValue : String) {
        
        let value = hexValue.hasPrefix("#") ? hexValue.subString(from: 1, to: hexValue.count) : hexValue
        guard value.count == 6 else {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
            return
        }
        assert(value.count == 6)
        
        let rStart = value.startIndex;
        let rEnd   = value.index(value.startIndex, offsetBy: 2)
        let gEnd   = value.index(value.startIndex, offsetBy: 4)
        let bEnd   = value.index(value.startIndex, offsetBy: 6)
        
        let r = hexToDec(hex: String(value[rStart..<rEnd]))
        let g = hexToDec(hex: String(value[rEnd..<gEnd]))
        let b = hexToDec(hex: String(value[gEnd..<bEnd]))
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    /// 十六进制颜色
    public convenience init(hexValue : String, alpha : CGFloat) {
        
        let value = hexValue.hasPrefix("#") ? hexValue.subString(from: 1, to: hexValue.count) : hexValue
        guard value.count == 6 else {
            self.init(red: 1, green: 1, blue: 1, alpha: alpha)
            return
        }
        assert(value.count == 6)
        
        let rStart = value.startIndex;
        let rEnd   = value.index(value.startIndex, offsetBy: 2)
        let gEnd   = value.index(value.startIndex, offsetBy: 4)
        let bEnd   = value.index(value.startIndex, offsetBy: 6)
        
        let r = hexToDec(hex: String(value[rStart..<rEnd]))
        let g = hexToDec(hex: String(value[rEnd..<gEnd]))
        let b = hexToDec(hex: String(value[gEnd..<bEnd]))
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
}
