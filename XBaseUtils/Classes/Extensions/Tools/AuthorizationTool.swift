//
//  AuthorizationTool.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/9.
//

import UIKit
import Photos
import AVFoundation
import CoreLocation
import CoreTelephony
import EventKit
import CoreBluetooth
import Contacts

public enum AuthorizationType: String {
    case photoAlbum  //相册
    case camera      //相机
    case microphone  //麦克风
    case location    //定位
    case push        //推送
    case network     //联网
    case calendars   //日历
    case contacts    //通讯录
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
open class AuthorizationTool: NSObject {
    
    ///跳转到设置界面
    open class func turnOnAuthorizations() {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options: [String:Any](), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
        }
    }
    
    open class func isAllowed(type: AuthorizationType) -> Bool {
        let result: Bool
        switch type {
        case .photoAlbum:
            result = isAllowedPhontoAlbum()
        case .camera:
            result = isAllowedCamera()
        case .microphone:
            result = isAllowedMicroPhone()
        case .location:
            result = isAllowedLocation()
        case .push:
            result = isAllowedPush()
        case .network:
            result = isAllowedNetwork()
        case .calendars:
            result = isAllowedCalendar()
        case .contacts:
            result = isAllowedContacts()
        }
        return result
    }
    
    private class func isAllowedPhontoAlbum() -> Bool {
        let photoAuthorStatus = PHPhotoLibrary.authorizationStatus()
        if photoAuthorStatus == PHAuthorizationStatus.authorized {
            return true
        }else {
            return false
        }
    }
    
    private class func isAllowedCamera() -> Bool{
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if videoAuthStatus == AVAuthorizationStatus.authorized {
            return true
        }else {
            return false
        }
    }
    
    private class func isAllowedMicroPhone() -> Bool {
        let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        if videoAuthStatus == AVAuthorizationStatus.authorized{
            return true
        }else {
            return false
        }
    }
    
    private class func isAllowedLocation() -> Bool {
        let result = CLLocationManager.authorizationStatus()
        if  (result == CLAuthorizationStatus.denied) ||
            (result == CLAuthorizationStatus.notDetermined) ||
            (result == CLAuthorizationStatus.restricted){
            return false
        }
        return true
    }
    
    private class func isAllowedPush() -> Bool {
        let setting = UIApplication.shared.currentUserNotificationSettings
        if setting?.types == UIUserNotificationType.sound {
            return false
        }
        return true
    }
    
    private class func isAllowedNetwork() -> Bool {
        if #available(iOS 9.0, *) {
            let state = CTCellularData().restrictedState
            if state == CTCellularDataRestrictedState.notRestricted {
                return true
            }
            return false
        }else {
            //TODO
            return false
        }
    }
    
    private class func isAllowedCalendar() -> Bool {
        let state = EKEventStore.authorizationStatus(for: EKEntityType.event)
        if state ==  EKAuthorizationStatus.authorized {
            return true
        }
        return false
    }
    
    private class func isAllowedContacts() -> Bool {
        if #available(iOS 9.0, *) {
            let status = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
            if status == CNAuthorizationStatus.authorized {
                return true
            }
            return false
        }else {
            //TODO
            return false
        }
    }
}


