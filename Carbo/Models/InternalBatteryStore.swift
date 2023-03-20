//
//  InternalBatteryStore.swift
//  Carbo
//
//  Created by MarioMang on 2022/11/16.
//
import os
import SwiftUI

@MainActor
class InternalBatteryStore: ObservableObject {
    private var service: io_connect_t = 0
    
    private let logger = Logger(subsystem: "com.darkiiiiiice.mariomang", category: "Carbo")
    @Published var isCharging: Bool = false
    @Published var temperature: Double = 0
    
    var battery: InternalBattery?
    
    init() {
        self.service = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("AppleSmartBattery"))
    }
    
    func refresh() async {
        var props: Unmanaged<CFMutableDictionary>?
        var battery = InternalBattery()
        
        if IORegistryEntryCreateCFProperties(self.service, &props, kCFAllocatorDefault, 0) == KERN_SUCCESS {
            if let props = props {
                let dict = props.takeRetainedValue() as NSDictionary
//                print(dict)
                
                if  let rawIsCharging = dict["IsCharging"] {
                
                    
                    print("get \(rawIsCharging)")
                    if let boolIsCharging = rawIsCharging as? Bool {
                        print(boolIsCharging)
                        
                        logger.notice("get is charging \(boolIsCharging, privacy: .public)")
                        self.isCharging = boolIsCharging
                    }
                }
                
                if let rawTemperature = dict["Temperature"] {
                    print("get \(rawTemperature)")
                    if let doubleTemperature = rawTemperature as? Double {
                        print(doubleTemperature)
                        self.temperature = doubleTemperature / 100.0
                    }
                }
//                let str = dict.value(forKey: "IsCharging") as! __NSCFBoolean
//                
//                print(str)
                
                
//                if  let isCharging = dict["IsCharging"] {
//                    print(isCharging)
//
//                    let str =
//                    print(str)
//                    if isCharging == "0" {
//                        self.isCharging = true
//                    } else if isCharging == "1" {
//                        self.isCharging = false
//                    }
//                }

//                let detail = dict["AdapterDetails"] as! NSDictionary
//                print(detail)
                
                
            }
        }
        
        self.battery = battery
    }
    
    func close() {
        IOServiceClose(self.service)
        IOObjectRelease(self.service)
        
        self.service = 0
    }
}
