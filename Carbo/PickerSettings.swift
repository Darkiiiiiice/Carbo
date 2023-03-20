//
//  PickerSettings.swift
//  Carbo
//
//  Created by MarioMang on 2022/11/21.
//
import AppKit

class PickerSettings: ObservableObject {
    @Published var colorSpace: NSColorSpace = .deviceRGB
    @Published var displayMode: DisplayMode = .rgb
    
    let colorSpaces: [Int: (String, NSColorSpace)] = [
        0: ("Device RGB", .deviceRGB),
        1: ("P3", .displayP3),
        2: ("sRGB", .sRGB),
        3: ("Generic RGB", .genericRGB),
        4: ("Adobe RGB", .adobeRGB1998),
    ]
    
    enum DisplayMode: Int {
        case rgb
        case argb
        case hex
    }
    func colorspace() {
        if let colorSpace = colorSpaces[UserDefaults.standard.integer(forKey: "colorSpace")] {
            self.colorSpace = colorSpace.1
        } else {
            self.colorSpace = .deviceRGB
        }
    }
    
    func displaymode() {
        self.displayMode = PickerSettings.DisplayMode(rawValue: UserDefaults.standard.integer(forKey: "displayMode")) ?? .rgb
    }
    
    
    func getColorspace() -> NSColorSpace {
        guard let colorSpace = colorSpaces[UserDefaults.standard.integer(forKey: "colorSpace")] else {
            self.setColorspace(0)
            return .deviceRGB
        }
        return colorSpace.1
    }
    
    func setColorspace(_ key: Int) {
        UserDefaults.standard.set(key, forKey: "colorSpace")
        self.colorSpace = colorSpaces[key]?.1 ?? .deviceRGB
    }
    
    func getDisplayMode() -> PickerSettings.DisplayMode {
        PickerSettings.DisplayMode(rawValue: UserDefaults.standard.integer(forKey: "displayMode")) ?? .rgb
    }
    
    func setDisplayMode(_ mode: PickerSettings.DisplayMode) {
        UserDefaults.standard.set(mode.rawValue, forKey: "displayMode")
        self.displayMode = mode
    }
}
