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
    
    /// An interface for CLDeviceCoordinator to injecting a new CLDeviceEventModel synchronously
    /// - Parameter model: CLDeviceEventModel
    func record(model: CLDeviceEventModel)
    
    /// An interface for CLDeviceCoordinator to injecting a new CLDeviceEventModel
    /// - Parameter model: CLDeviceEventModel
    func record(_ model: CLDeviceEventModel) async
    
    /// An interface for CLDeviceCoordinator to fetching collections of CLDeviceEventModel
    /// - Parameters:
    ///   - in date: passing a date-object as a constraint using in the action of models-feching
    ///   - of event: passing a CLDeviceCoordinator.Event as a constraint using in the action of models-fetching operation
    /// - Returns: [CLDeviceEventModel]
    typealias Event = CLDeviceCoordinator.Event
    func fetches(in date: Date?, of event: Event?, exclude events: [Event]?) async -> [CLDeviceEventModel]
    
}
