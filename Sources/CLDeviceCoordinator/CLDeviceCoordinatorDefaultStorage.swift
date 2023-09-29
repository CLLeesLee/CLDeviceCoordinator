//
//  File.swift
//  
//
//  Created by ColdLess Lee on 2023/9/29.
//

import Foundation
import UniformTypeIdentifiers

actor CLDeviceCoordinatorDefaultStorage {
    
    /// the filename of default storage in FileManger
    public let key = "cl.default.storage"
    
    /// the models for CLDeviceCoordinator
    public var models: [CLDeviceEventModel] {
        get { getModels() }
        set { set(models: newValue) }
    }
}

// MARK: Private
extension CLDeviceCoordinatorDefaultStorage {
    
    /// setting CLDeviceCoordinator's models by using the FileManger
    /// - Parameter models: [CLDeviceEventModel]
    private func set(models: [CLDeviceEventModel]) {
        do {
            let base = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let url = base.appendingPathComponent(key, conformingTo: .json)
            let datas = try JSONEncoder().encode(models)
            try datas.write(to: url)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    /// getting CLDeviceCoordinator's models by using the FileManger
    /// - Returns: [CLDeviceEventModel]
    private func getModels() -> [CLDeviceEventModel] {
        do {
            let base = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let url = base.appendingPathComponent(key, conformingTo: .json)
            let datas = try Data(contentsOf: url)
            let objects: [CLDeviceEventModel] = try JSONDecoder().decode([CLDeviceEventModel].self, from: datas)
            return objects
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
    
}

extension CLDeviceCoordinatorDefaultStorage: CLDeviceCoordinatorStorage {
    
    nonisolated func record(model: CLDeviceEventModel) {
        do {
            let base = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let url = base.appendingPathComponent(key, conformingTo: .json)
            let datas = try Data(contentsOf: url)
            var objects: [CLDeviceEventModel] = try JSONDecoder().decode([CLDeviceEventModel].self, from: datas)
            objects.append(model)
            let newDatas = try JSONEncoder().encode(objects)
            try newDatas.write(to: url)
        } catch {
            debugPrint(error.localizedDescription)
        }

    }
    
    func record(_ model: CLDeviceEventModel) async {
        self.models.append(model)
    }
    
    func fetches(in date: Date?, of event: CLDeviceCoordinator.Event?) async -> [CLDeviceEventModel] {
        var models = self.models
        if let date = date {
            let calendar = Calendar.current
            models = models.filter { model in
                calendar.isDate(model.date, inSameDayAs: date)
            }
        }
        if let event = event {
            models = models.filter { model in
                model.event == event
            }
        }
        return models
    }
    
    
}

