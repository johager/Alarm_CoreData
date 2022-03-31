//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by James Hager on 3/31/22.
//

import CoreData

class AlarmController: AlarmScheduler {
    
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
        let alarm = Alarm(title: title, fireDate: fireDate, isEnabled: isEnabled)
        alarms.append(alarm)
        saveToPersistentStore()
        
        scheduleUserNotifications(for: alarm)
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
        let previousFireDate = alarm.fireDate
        let previousIsEnabled = alarm.isEnabled
        
        alarm.set(title: title, fireDate: fireDate, isEnabled: isEnabled)
        saveToPersistentStore()
        
        guard fireDate != previousFireDate || isEnabled != previousIsEnabled else { return }
        
        cancelUserNotifications(for: alarm)
        
        guard isEnabled else { return }
        
        scheduleUserNotifications(for: alarm)
    }
    
    func toggleIsEnabled(for alarm: Alarm) {
        alarm.isEnabled.toggle()
        saveToPersistentStore()
        
        if alarm.isEnabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
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
        
        cancelUserNotifications(for: alarm)
    }
    
    func deleteAlarm(atIndex index: Int) {
        delete(alarms[index])
    }
}
