//
//  String+Extension.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/5.
//

import Foundation

extension String {
    
    /// 截取子字符串
    public func subString(from index: Int, length: Int) -> String {
        guard !isEmpty else { return self }
        
        let startIndex = self.index(self.startIndex, offsetBy: index)
        let endIndex = self.index(self.startIndex, offsetBy: index + length)
        
        let subString = self[startIndex..<endIndex]
        
        return String(subString)
    }
    
    /// 截取子字符串
    public func subString(from: Int, to: Int) -> String {
        assert(to > from, "to必须大于from")
        guard !isEmpty else { return self }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to)
        
        let subString = self[startIndex...endIndex]
        
        return String(subString)
    }
    
    /// 截取子字符串
    public func subString(to: Int) -> String {
        return subString(from: 0, to: to)
    }
    
    /// 截取子字符串
    public func subString(from: Int) -> String {
        return subString(from: from, to: self.count - 1)
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension String {
    
    /// 替换指定范围内的字符串
    mutating func stringByReplacingCharactersInRange(index: Int,length: Int, replacText: String) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: index)
        self.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: length), with: replacText)
        return self
    }
    
    /// 替换指定字符串
    mutating func stringByReplacingstringByReplacingString(text: String, replacText: String) -> String {
        return self.replacingOccurrences(of: text, with: replacText)
    }
    
    /// 删除最后一个字符
    mutating func deleteEndCharacters() -> String {
        self.remove(at: self.index(before: self.endIndex))
        return self
    }
    
    /// 删除指定字符串
    mutating func deleteString(string:String) -> String {
        return self.replacingOccurrences(of: string, with: "")
    }
    
    /// 字符串分割
    func split(string:String) -> [String] {
        return NSString(string: self).components(separatedBy: string)
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension String {
    
    /// URL编码
    public var urlEncoded: String {
        let characterSet = CharacterSet(charactersIn: ":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`")
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)!
        
    }
    
    /// URL解码
    public var urlDecode: String? {
        return self.removingPercentEncoding
    }
    
    /// Base64编码
    var base64: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    
    /// Base64解码
    public var base64Decode: String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    /// md5加密
//    func md5() -> String {
//        let str = self.cString(using: .utf8)
//        let strLen = CUnsignedInt(self.lengthOfBytes(using: .utf8))
//        let digestLen = Int(16)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        CC_MD5(str,strLen,result)
//        let hash = NSMutableString()
//
//        for i in 0..<digestLen{
//            hash.appendFormat("%02x", result[i])
//        }
//
//        return hash as String
//    }
    
    /// 是否是邮箱
    public var isEmail: Bool {
        return range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// 是否是URL
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// 是否是手机号
    public var isMobile: Bool {
        guard !self.isEmpty else {
            return false
        }
        let phoneRegix = "[123456789][0-9]{8}([0-9]{1})?"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegix)
        return phoneTest.evaluate(with: self)
    }
    
    /// 是否是字母数字的组合
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension String {
    
    /// 转换成Int类型
    public func toInt() -> Int? {
        guard let intValue = NumberFormatter().number(from: self) else {
            return nil
        }
        return intValue.intValue
    }
    
    /// 转换成Double类型
    public func toDouble() -> Double? {
        guard let doubleValue = NumberFormatter().number(from: self) else {
            return nil
        }
        return doubleValue.doubleValue

    }
    
    /// 转换成Float类型
    public func toFloat() -> Float? {
        guard let floatValue = NumberFormatter().number(from: self) else {
            return nil
        }
        return floatValue.floatValue
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension String {
    
    /// 获取文本高度
    public func getTextHeight(font : UIFont = UIFont.systemFont(ofSize: 18), fixedWidth : CGFloat) -> CGFloat {
        
        guard self.count > 0 && fixedWidth > 0 else {
            return 0
        }
        
        let size = CGSize(width:fixedWidth, height:CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return rect.size.height
    }
    
    /// 获取文本宽度
    public func getTextWidth(font : UIFont = UIFont.systemFont(ofSize: 17)) -> CGFloat {
        
        guard self.count > 0 else {
            return 0
        }
        
        let size = CGSize(width:CGFloat.greatestFiniteMagnitude, height:0)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return rect.size.width
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
extension String {
    
    /// 将服务器返回的秒字符串转换为时间字符串
    public func convertToDateString() -> String {
        return convertToDateString(formatterString: "yyyy-MM-dd HH:mm")
    }
    
    /// 将服务器返回的秒字符串转换为时间字符串
    public func convertToDateString(formatterString: String) -> String {
        guard let seconds = Double(self) else {
            return ""
        }
        let date = Date(timeIntervalSince1970: seconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatterString
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
