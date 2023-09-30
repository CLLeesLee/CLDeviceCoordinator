//
//  File.swift
//  
//
//  Created by ColdLess Lee on 2023/9/29.
//

import Foundation

class CLDeviceTimingComputer {
    
    /// the sleep time-hour of user device
    public static var sleepTimeHour: Int {
        get { UserDefaults.userSleepTimeHour }
        set { UserDefaults.userSleepTimeHour = newValue }
    }
    
    /// the sleep time-minute of user device
    public static var sleepTimeMinute: Int {
        get { UserDefaults.userSleepTimeMinute }
        set { UserDefaults.userSleepTimeMinute = newValue }
    }
    
    /// the awake time-hour of user device
    public static var awakeTimeHour: Int {
        get { UserDefaults.userAwakeTimeHour }
        set { UserDefaults.userAwakeTimeHour = newValue }
    }
    
    /// the awake time-minute of user device
    public static var awakeTimeMinute: Int {
        get { UserDefaults.userAwakeTimeMinute }
        set { UserDefaults.userAwakeTimeMinute = newValue }
    }
    
}

// MARK: Public
extension CLDeviceTimingComputer {
    
    /// judging if the date that inputted is a sensitive timing witch is contained by the time-range setted by the user
    /// - Parameter date: Date
    /// - Returns: Bool
    public static func isSensitiveTiming(of date: Date) -> Bool {
        // get the same day values
        let timing = Timing(date: date)
        // sleep date value
        let sleepTiming = Timing(hour: CLDeviceTimingComputer.sleepTimeHour, minute: CLDeviceTimingComputer.sleepTimeMinute)
        // awake date value
        let awakeTiming = Timing(hour: CLDeviceTimingComputer.awakeTimeHour, minute: CLDeviceTimingComputer.awakeTimeMinute)
        // create a range for biggest to smallest
        let biggest = max(sleepTiming, awakeTiming)
        let smallest = min(sleepTiming, awakeTiming)
        let range = smallest...biggest
        // condiction if user is sleeping at night
        // if user is sleeping at the night, return the value witch is not contained by the range
        // else return the value witch is contained by the range
        let isSleepingAtNight = sleepTiming > awakeTiming
        return isSleepingAtNight ? !range.contains(timing) : range.contains(timing)
    }
    
    /// judging if the date that inputted is not a sensitive timing witch is contained by the time-range setted by the user
    /// - Parameter date: Date
    /// - Returns: Bool
    public static func isNotSensitiveTiming(of date: Date) -> Bool {
        !CLDeviceTimingComputer.isSensitiveTiming(of: date)
    }
    
}

// MARK: Objects Definations
extension CLDeviceTimingComputer {
    
    /// the timing object that could describing a timing of a day
    struct Timing: Comparable {
        
        var hour: Int
        var minute: Int
        
        init(hour: Int, minute: Int) {
            self.hour = hour
            self.minute = minute
        }
        
        init(date: Date) {
            // get the same day values
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            self.init(hour: hour, minute: minute)
        }
        
        init?(optionalDateObject date: Date?) {
            guard let date = date else { return nil }
            self.init(date: date)
        }
        
        static func < (lhs: CLDeviceTimingComputer.Timing, rhs: CLDeviceTimingComputer.Timing) -> Bool {
            let condiction_hour = lhs.hour < rhs.hour
            let condiction_munite = lhs.hour == rhs.hour && lhs.minute < rhs.minute
            return condiction_hour || condiction_munite
        }
        
        static func == (lhs: CLDeviceTimingComputer.Timing, rhs: CLDeviceTimingComputer.Timing) -> Bool {
            lhs.hour == rhs.hour && lhs.minute == rhs.minute
        }
        
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
