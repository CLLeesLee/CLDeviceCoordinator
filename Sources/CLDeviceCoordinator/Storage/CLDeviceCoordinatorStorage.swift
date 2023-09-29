//
//  File.swift
//  
//
//  Created by ColdLess Lee on 2023/9/29.
//

import Foundation

/// The data model witch can link CLDeviceCoordinator to CLDeviceCoordinatorStorage that is custom by developer
struct CLDeviceEventModel: Codable {
    /// the event occured date
    var date: Date = .now
    
    /// CLDeviceCoordinator.Event
    var event: CLDeviceCoordinator.Event
}

/// The interfaces that a CLDeviceCoordinatorStorage must be implement
protocol CLDeviceCoordinatorStorage {
    
    /// the interface witch can be call in the sync context
    /// - Parameter model: CLDeviceEventModel
    func record(model: CLDeviceEventModel)
    
    /// the interface witch will receive the CLDeviceEventModel from CLDeviceCoordinator
    /// - Parameter model: CLDeviceEventModel
    func record(_ model: CLDeviceEventModel) async
    
    /// the interface witch can be fething the collection of CLDeviceEventModel by CLDeviceCoordinator
    /// - Parameters:
    ///   - in date: passing a date object as a constraint using in the action of models-feching
    ///   - of event: passing an CLDeviceCoordinator.Event as a constraint using in the action of models-fetching
    /// - Returns: [CLDeviceEventModel]
    func fetches(in date: Date?, of event: CLDeviceCoordinator.Event?) async -> [CLDeviceEventModel]
    
}
