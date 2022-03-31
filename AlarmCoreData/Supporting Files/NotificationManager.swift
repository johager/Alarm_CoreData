//
//  NotificationManager.swift
//  AlarmCoreData
//
//  Created by James Hager on 3/31/22.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    
    override init() {
        super.init()
        requestPermission()
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("we have permission to send notifications")
                self.setUp()
            } else if let error = error {
                print("error obtaining permission to send notifications: \(error.localizedDescription)")
            }
        }
    }
    
    func setUp() {
        UNUserNotificationCenter.current().delegate = self
        
//        let action = UNNotificationAction(identifier: Strings.notificationActionIdentifier, title: "Alarm", options: [])
//        let category = UNNotificationCategory(identifier: Strings.notificationCategoryIdentifier, actions: [action], intentIdentifiers: [], options: [.customDismissAction])
//        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.sound, .badge, .banner])
    }
}
