//
//  File.swift
//  
//
//  Created by ColdLess Lee on 2023/9/29.
//

import Foundation

class CLDeviceTimingComputer {
    
    public static var sleepTimeHour: Int {
        get { UserDefaults.userSleepTimeHour }
        set { UserDefaults.userSleepTimeHour = newValue }
    }
    
    public static var sleepTimeMinute: Int {
        get { UserDefaults.userSleepTimeMinute }
        set { UserDefaults.userSleepTimeMinute = newValue }
    }
    
    public static var awakeTimeHour: Int {
        get { UserDefaults.userAwakeTimeHour }
        set { UserDefaults.userAwakeTimeHour = newValue }
    }
    
    public static var awakeTimeMinute: Int {
        get { UserDefaults.userAwakeTimeMinute }
        set { UserDefaults.userAwakeTimeMinute = newValue }
    }
    
}



// MARK: For implementations to user setting sleep range
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
