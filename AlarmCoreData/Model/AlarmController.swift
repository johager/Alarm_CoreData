//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by James Hager on 3/31/22.
//

import CoreData

class AlarmController {
    
    static let shared = AlarmController()
    
    var alarms = [Alarm]()
    
    private init() {
        fetchAlarms()
    }
    
    func saveToPersistentStore() {
        CoreDataStack.saveContext()
    }
    
    // MARK: - CRUD
    
    func createAlarm(withTitle title: String, andFireDate fireDate: Date, isEnabled: Bool) {
        alarms.append(Alarm(title: title, fireDate: fireDate, isEnabled: isEnabled))
        saveToPersistentStore()
    }
    
    func fetchAlarms() {
        let request = NSFetchRequest<Alarm>(entityName: Strings.alarmEntityName)
        
        do {
            alarms = try CoreDataStack.context.fetch(request)
        } catch {
            print("Error fetching alarms: \(error.localizedDescription)")
        }
    }
    
    func update(_ alarm: Alarm, title: String, fireDate: Date, isEnabled: Bool) {
        alarm.set(title: title, fireDate: fireDate, isEnabled: isEnabled)
        saveToPersistentStore()
    }
    
    func toggleIsEnabled(for alarm: Alarm) {
        alarm.isEnabled.toggle()
        saveToPersistentStore()
    }
    
    func toggleIsEnabledForAlarm(atIndex index: Int) {
        toggleIsEnabled(for: alarms[index])
    }
    
    func delete(_ alarm: Alarm) {
        if let index = alarms.firstIndex(of: alarm) {
            alarms.remove(at: index)
        }
        CoreDataStack.context.delete(alarm)
        saveToPersistentStore()
    }
    
    func deleteAlarm(atIndex index: Int) {
        delete(alarms[index])
    }
}
