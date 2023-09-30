//
//  File.swift
//  
//
//  Created by ColdLess Lee on 2023/9/30.
//

import Foundation

/// The service plugin for CLDeviceCoordinator, that can provide some abilities like networking-ability to coordinator
protocol CLDeviceSleepService {
    
    /// it will be called when the user's device meets the condiction that is named `asleep` of coordinator's sleep-manager
    func dispatchSleep(at date: Date) async
   
    /// it will be called when the user's device meets the condiction that is named `awaked` of coordinator's sleep-manager
    func dispatchAwake(at date: Date) async
        
    /// it will be called when the user's device meets the condiction that is named `appclosed` of coordinator's sleep-manager
    func dispatchApplicationAboutToLeave(at date: Date)
    
}
