// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import Foundation

final class CLDeviceCoordinator {
    /// singleton
    public static let `default` = CLDeviceCoordinator()
    
    /// coordinator's sleep-manger, that can provide the ability and the logical of user's device sleep moritoring
    public let sleepManager: CLDeviceSleepManager = CLDeviceSleepManager()
    
    /// coordinator's storage, that can saving data-model witch is from coordinator's specific event
    public private(set) var storage: CLDeviceCoordinatorStorage = CLDeviceCoordinatorDefaultStorage()
    
    /// The service plugin for CLDeviceCoordinator, that can provide some abilities like networking-ability to coordinator
    public private(set) var service: CLDeviceSleepService?
    
    private init() {
        addNotifications()
    }
    
}

// MARK: definations
extension CLDeviceCoordinator {
    
    @propertyWrapper
    struct CLUserDefaults<Value> {
        let key: String
        let defaultValue: Value
        var container: UserDefaults = .standard

        var wrappedValue: Value {
            get {
                return container.object(forKey: key) as? Value ?? defaultValue
            }
            set {
                container.set(newValue, forKey: key)
            }
        }
    }
    
}

// MARK: Events
extension CLDeviceCoordinator {
    
    /// The event in Coordinator logical
    public enum Event: Codable {
        case locked
        case unlocked
        case deviceKilled
    }
    
}

// MARK: Private Methods
extension CLDeviceCoordinator {
    
    /// adding observations to NotificationCenter's notifications thats is menber of UIApplication
    private func addNotifications() {
        
        let locked = UIApplication.protectedDataWillBecomeUnavailableNotification
        NotificationCenter.default.addObserver(forName: locked, object: self, queue: .current) { [unowned self] notify in
            self.deviceLockedAction(notify)
        }
        
        let unlocked = UIApplication.protectedDataDidBecomeAvailableNotification
        NotificationCenter.default.addObserver(forName: unlocked, object: self, queue: .current) { [unowned self] notify in
            self.deviceUnlockAction(notify)
        }
        
        let terminated = UIApplication.willTerminateNotification
        NotificationCenter.default.addObserver(forName: terminated, object: self, queue: .current) { [unowned self] notify in
            self.deviceKillAppcationAction(notify)
        }
        
    }
    
    /// the action will excute when user will lock device
    /// - Parameter notification: the notification from UIApplication
    private func deviceLockedAction(_ notification: Notification) {
        Task {
            // generateModel
            let model = CLDeviceEventModel(event: .locked)
            await storage.record(model)
        }
    }
    
    /// the action will excute when user will unlock device
    /// - Parameter notification: the notification from UIApplication
    private func deviceUnlockAction(_ notification: Notification) {
        // generateModel
        Task {
            let model = CLDeviceEventModel(event: .unlocked)
            await storage.record(model)
        }
        
    }
    
    /// the action will excute when user will kill this program
    /// - Parameter notification: the notification from UIApplication
    private func deviceKillAppcationAction(_ notification: Notification) {
        // generateModel
        let model = CLDeviceEventModel(event: .deviceKilled)
        storage.record(model: model)
    }
    
}

// MARK: Public Methods
extension CLDeviceCoordinator {
    
    /// launching this Coordinator's share singleton
    /// - Parameter bring storage: the object that is confirming to CLDeviceCoordinatorStorage(Optional)
    public func launch<T>(bring storage: T? = nil) where T: CLDeviceCoordinatorStorage {
        let className = String(describing: CLDeviceCoordinator.self)
        let memoryDescription = String(describing: self)
        debugPrint("\(className) initialized with \(memoryDescription)")
        // set storage
        if let storage = storage {
            self.storage = storage
        }
    }
    
    /// injecting a service plugin to coordinator
    /// - Parameter service: an object that is conform to the protocol named `CLDeviceSleepService`
    public func inject<T>(service: T) where T: CLDeviceSleepService {
        self.service = service
    }
    
}
