//
//  File.swift
//  
//
//  Created by ColdLess Lee on 2023/9/29.
//

import Foundation

class CLDeviceSleepManager {
    
}

extension CLDeviceSleepManager {
    
}

fileprivate extension UserDefaults {
    @CLDeviceCoordinator.CLUserDefaults(key: "___user_sleep_time_hour___", defaultValue: 21)
    static var userSleepTimeHour: Int
    
    @CLDeviceCoordinator.CLUserDefaults(key: "___user_sleep_time_minute___", defaultValue: 30)
    static var userSleepTimeMinute: Int
    
    @CLDeviceCoordinator.CLUserDefaults(key: "___user_awake_time_hour___", defaultValue: 6)
    static var userAwakeTimeHour: Int
    
    @CLDeviceCoordinator.CLUserDefaults(key: "___user_awake_time_minute___", defaultValue: 30)
    static var userAwakeTimeMinute: Int
}
