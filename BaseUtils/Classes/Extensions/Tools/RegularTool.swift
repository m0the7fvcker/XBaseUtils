//
//  RegularTool.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/9.
//

import Foundation

enum RegualrValidateType: Int {
    case email           //邮箱
    case phoneNumber     //电话
    case number          //数字
    case chinese         //中文
    case url             //URl
    case qq              //QQ
    case blankLine       //空行
    case idCard          //身份证
    case illeglaCharacter //合法字符
}

func validateText(validateType: RegualrValidateType, validateString: String) -> Bool {
    do {
        let pattern: String
        
        switch validateType {
        case .email:
            pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        case .phoneNumber:
            pattern = "^1[0-9]{10}$"
        case .number:
            pattern = "^[0-9]*$"
        case .chinese:
            pattern = "^[\\u4e00-\\u9fa5]{0,}$"
        case .url:
            pattern = "^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$"
        case .qq:
            pattern = "[1-9][0-9]{4,}"
        case .blankLine:
            pattern = "^s*|s*$"
        case .idCard:
            pattern = "\\d{14}[[0-9],0-9xX]"
        case .illeglaCharacter:
            pattern = "[%&',;=?$\\\\^]+"
        }
        let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        
        let matches = regex.matches(in: validateString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, validateString.count))
        return matches.count > 0

    }
    catch {
        return false
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
class RegularTool {
    
    class func emailIsValidated(vStr: String) -> Bool {
        return validateText(validateType: .email, validateString: vStr)
    }
    
    class func PhoneNumberIsValidated(vStr: String) -> Bool {
        return validateText(validateType: .phoneNumber, validateString: vStr)
    }
    
    class func numberIsValidated(vStr: String) -> Bool {
        return validateText(validateType: .number, validateString: vStr)
    }
    
    class func chineseIsValidated(vStr: String) -> Bool {
        return validateText(validateType: .chinese, validateString: vStr)
    }
    
    class func illegalCharacterIsValidated(vStr: String) -> Bool {
        return validateText(validateType: .illeglaCharacter, validateString: vStr)
    }
    
    class func urlIsValidated(vStr: String) -> Bool {
        return validateText(validateType: .url, validateString: vStr)
    }
    
    class func blankLinesIsValidated(vStr: String) -> Bool {
        return validateText(validateType: .blankLine, validateString: vStr)
    }
    
    class func qqIsValidated(vStr: String) -> Bool {
        return validateText(validateType: .qq, validateString: vStr)
    }

    class func IdCardIsValidated(vStr: String) -> Bool {
        return validateText(validateType: .idCard, validateString: vStr)
    }
}

