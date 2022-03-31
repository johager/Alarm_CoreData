//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by James Hager on 3/31/22.
//

import Foundation
import UserNotifications

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

// MARK: - Default Implementation

extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "⏰"
        content.body = alarm.title
        content.sound = .default
        content.userInfo = [Strings.alarmIdKey: alarm.id]
        content.categoryIdentifier = Strings.notificationCategoryIdentifier
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("There was an error setting up the notification for \(alarm.title): \(error.localizedDescription)")
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id])
    }
}
