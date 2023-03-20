//
//  MacOS_Scene.swift
//  Carbo
//
//  Created by MarioMang on 2022/11/17.
//

import AppKit
import SwiftUI

struct MacOS_Scene: Scene {
    @StateObject var battery = InternalBatteryStore()


    
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
    
    
    init() {
       
    }

    var body: some Scene {
//        WindowGroup {
//            MenuBarView()
//        }
//        .windowStyle(.hiddenTitleBar)
//        .windowToolbarStyle(.automatic)


        MenuBarExtra(String(battery.temperature), systemImage: "qrcode", isInserted: $showMenuBarExtra) {
                MenuBarView()
                
            
        }
        .menuBarExtraStyle(.window)
        .windowResizability(.contentMinSize)
    }
    
    func runBatteryTask ()  {
        Task.init {
            do {
                while true {
                    try await Task.sleep(for: .seconds(1))
                    await battery.refresh()
                    print(showMenuBarExtra)
                }
            } catch {}
        }
    }
}
