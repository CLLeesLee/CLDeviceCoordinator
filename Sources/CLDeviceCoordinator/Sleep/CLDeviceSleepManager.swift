//
//  File.swift
//  
//
//  Created by ColdLess Lee on 2023/9/29.
//

import Foundation

class CLDeviceSleepManager {
    
    private weak var timer: DispatchSourceTimer? = nil
    private let timerQueue: DispatchConcurrentQueue = .init(label: "cl.device.coordinator.sleep.manager.concurrent.queue")
}

extension CLDeviceSleepManager {
    
}
