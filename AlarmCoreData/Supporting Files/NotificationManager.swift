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
                UNUserNotificationCenter.current().delegate = self
            } else if let error = error {
                print("error obtaining permission to send notifications: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.sound, .badge, .banner])
    }
}
