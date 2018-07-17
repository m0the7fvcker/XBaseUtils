//
//  CommonConst.swift
//  XBaseUtils
//
//  Created by Poly.ma on 2018/7/17.
//

import UIKit

/////////////////////////////////////////////Block/////////////////////////////////////////////////////
typealias DCBasicBlock = ()->Void
typealias DCDoubleReturnBlock = ()->Double
typealias DCStringBlock = (_ text : String) -> Void
typealias DCIndexBlock  = (_ index : Int) -> Void
typealias DCIndexRetrunStringBlock  = (_ index : Int) -> String
typealias DCBoolBlock   = (_ status : Bool) ->Void
typealias DCDictionaryBlock = (_ dic : Dictionary<String, Any>) -> Void

/////////////////////////////////////////////Frame////////////////////////////////////////////////////
let SCREEN_WIDTH  = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let TAB_HEIGHT : CGFloat = DeviceIsIphoneX() ? 83 : 49
let NAV_HEIGHT : CGFloat = DeviceIsIphoneX() ? 88 : 64
let STATUSBAR_HEIGHT: CGFloat = DeviceIsIphoneX() ? 44 : 20
let PIXEL = 1.0 / UIScreen.main.scale

let TAB_BOTTOM_GAP: CGFloat = 34 // tab 底部间隙

let FRAME_SCALE_W : CGFloat = SCREEN_WIDTH / 375.0
let FRMAE_SCALE_H : CGFloat = SCREEN_HEIGHT / 667.0

//////////////////////////////////////////////Keys////////////////////////////////////////////////////
let UMessageKey = "592645a96e27a408e80002d2"
let kMapKey = "c7134e410b596552bf0f880e75b92ecc"

//////////////////////////////////////////////Noti////////////////////////////////////////////////////
let DistributionDesignerSelectNotificationName = "DistributionDesignerSelectNotificationName"
let DistributionDesignerNotificationName       = "DistributionDesignerNotificationName"
let DidAddAddressNotificationName              = "DidAddAddressNotificationName"
let DidAbandonOrderNotificationName            = "DidAbandonOrderNotificationName"
let RemindCompleteSubmitBidNotificationName    = "RemindCompleteSubmitBidNotificationName"
let DidReactiveFollowOrderNotificationName     = "DidReactiveFollowOrderNotificationName"
let DidCompanySignNotificationName             = "DidCompanySignNotificationName"
let DidSubmitBidNotificationName               = "DidSubmitBidNotificationName"
let DidSigninOrSignoutNotificationName         = "DidSigninOrSignoutNotificationName"
let AppVersionShouldUpdateName                 = "AppVersionShouldUpdateName"
let SendSuccessMessageNotificationName         = "SendSuccessMessageNotificationName"
let SendFailMessageNotificationName            = "SendFailMessageNotificationName"
let DidSendMessageNotificationName             = "DidSendMessageNotificationName"
let DidAddRecordNotificationName               = "DidAddRecordNotificationName"
let DidAppointedNotificationName               = "DidAppointedNotificationName"
let DidBindPhoneNumberNotificationName         = "DidBindPhoneNumberNotificationName"

/// 刷新辅材界面
let RefreshSubGoodsNotificationName            = "RefreshSubGoodsNotificationName"
/// 刷新辅材购物车角标数
let RefreshSubShoppingCarBageValueNotificationName = "RefreshSubShoppingCarBageValueNotificationName"

//////////////////////////////////////////////////UserDefault/////////////////////////////////////////
let deviceTokenKey = "deviceToken"

//////////////////////////////////////////////////Device//////////////////////////////////////////////
func DeviceIsIphoneX() -> Bool {
    return DeviceTool.shared.hardware() == .iphoneX
}

func DeviceIsIphone5() -> Bool {
    return DeviceTool.shared.hardware() == .iphone5
}

///////////////////////////////////////////////////AppInfo////////////////////////////////////////////
let APP_NAME                   = Bundle.main.infoDictionary?["CFBundleDisplayName"]
let APP_VERSION                = Bundle.main.infoDictionary?["CFBundleVersion"]
let NetAppName                 = "dsp-app"
let APP_ID                     = 77
let APP_VERSION_SHORT : String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
let IMAGE_PRIFIX = "http://pic.to8to.com"

//是否开启token验证
let isCheckToken = true

func HOST_ADDRESS()->String{
    return "https://cagw.to8to.com"
}

func SCMGWHOST()->String{
    return "https://scmgw.to8to.com"
}

/////////////////////////////////////////////////////Reg/////////////////////////////////////////////
func IsValidUrl(url : String) -> Bool{
    
    if url.count <= 0 { return false }
    let regex = "[a-zA-z]+://[^\\s]*"
    let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)//NSPredicate.init(format: "SELF MATCHES \(regex)")
    return predicate.evaluate(with: url)
}

func IsValidPhoneNumber(phoneNumber : String) -> Bool {
    if phoneNumber.count != 11 { return false }
    let regex = "0?(13|14|15|17|18|19)[0-9]{9}"
    let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)//NSPredicate.init(format: "SELF MATCHES \(regex)")
    return predicate.evaluate(with: phoneNumber)
}

func IsValidUserName(name: String) -> Bool {
    if name.count <= 0 { return false }
    let regex = "^[\u{4E00}-\u{9FA5A}-Za-z0-9]+$"
    let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)//NSPredicate.init(format: "SELF MATCHES \(regex)")
    return predicate.evaluate(with: name)
}

func IsValidLoginName(name: String) -> Bool {
    if name.count <= 0 { return false }
    let regex = "^[\u{4E00}-\u{9FA5A}-Za-z0-9-@_]+$"
    let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex)//NSPredicate.init(format: "SELF MATCHES \(regex)")
    return predicate.evaluate(with: name)
}


//////////////////////////////////////////////////////Tool///////////////////////////////////////////
func UPDATE_URL() -> String{
    return "https://itunes.apple.com/cn/app/tu-ba-tu-ti-yan-shi-chuang/id1250294203?l=en&mt=8"
}

func CURRENT_WINDOW() -> UIWindow{
    return UIApplication.shared.windows.first!
}

func UMWRAP_INT(_ i: Int?) -> Int {
    return i == nil ? 0 : i!
}

func UNWRAP_STRING(_ s: String?) -> String {
    return s == nil ? "" : s!
}

// 文件大小
func FileSize(path:String) -> Double {
    let manager = FileManager.default
    var fileSize:Double = 0
    do {
        let attr = try manager.attributesOfItem(atPath: path)
        fileSize = Double(attr[FileAttributeKey.size] as! UInt64)
        let dict = attr as NSDictionary
        fileSize = Double(dict.fileSize())
    } catch {
        dump(error)
    }
    return fileSize/1024/1024
}

func getLabelHeight(str:String,width:CGFloat,fontSize:CGFloat) -> CGFloat {
    var size:CGSize = CGSize.zero
    size = str.boundingRect(with: CGSize.init(width:width,height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: fontSize)], context: nil).size
    
    return size.height
}

//设置渐变色
func _setGradientForViewWithColor(_ aView:UIView,startColorStr:String,endColorStr:String,cornerRadius:CGFloat? = 0)  {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = aView.bounds
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    gradientLayer.colors = [UIColor(hexValue: startColorStr).cgColor,UIColor(hexValue: endColorStr).cgColor]
    gradientLayer.cornerRadius = cornerRadius ?? 0
    aView.layer.insertSublayer(gradientLayer, at: 0)
}

struct tConfig {
    
    static let shareConfig = tConfig()
    
    var launchIm: Bool = true
    var isDev: Bool = false
    
    private init() {
        
        guard let infoDcit = Bundle.main.infoDictionary, let configDict: [String: Any] = infoDcit["tConfig"] as? [String: Any] else {
            return
        }
        
        let kLaunchIm: String = configDict["kLaunchIm"] as! String
        self.launchIm = (kLaunchIm == "1")
        
        let isDev: String = configDict["isDev"] as! String
        self.isDev = (isDev == "1")
        
        //        self.launchIm = configDict["kLaunchIm"] as? Bool ?? true
        //        self.isDev = configDict["isDev"] as? Bool ?? false
    }
}
