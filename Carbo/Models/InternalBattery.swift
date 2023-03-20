//
//  InternalBattery.swift
//  Carbo
//
//  Created by MarioMang on 2022/11/16.
//

import SwiftUI

struct InternalBattery {
    public var name: String?
    public var timeToFull: Int?
    public var timeToEmpty: Int?

    public var manufacturer: String?
    public var manufactureDate: Date?

    public var currentCapacity: Int?
    public var maxCapacity: Int?
    public var designCapacity: Int?

    public var cycleCount: Int?
    public var designCycleCount: Int?

    public var acPowered: Bool?
    public var isCharging: Bool?
    public var isCharged: Bool?
    public var amperage: Int?
    public var voltage: Double?
    public var watts: Double?
    public var temperature: Double?

}
