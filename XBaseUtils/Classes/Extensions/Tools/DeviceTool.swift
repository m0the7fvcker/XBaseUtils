//
//  DeviceTool.swift
//  BaseUtils
//
//  Created by Poly.ma on 2018/7/10.
//

import Foundation
import DeviceGuru

/////////////////////////////////////////////////////////////////////////////////////////////////////
public class DeviceTool {
    var deviceManager: DeviceGuru = {
        return DeviceGuru()
    }()
    
    public static let shared = DeviceTool()
    private init() {}
    
    public func hardwareString() -> String {
        return deviceManager.hardwareString()
    }

    public func hardware() -> Hardware {
        return deviceManager.hardware()
    }

    public func platform() -> Platform {
        return deviceManager.platform()
    }
    
    public func hardwareDescription() -> String? {
        return deviceManager.hardwareDescription()
    }
    
    public func hardwareNumber() -> Float? {
        return deviceManager.hardwareNumber()
    }
    
    public func backCameraStillImageResolutionInPixels(_ hardware: Hardware) -> CGSize {
        return deviceManager.backCameraStillImageResolutionInPixels(_: hardware)
    }
}
