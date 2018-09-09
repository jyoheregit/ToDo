//
//  NotificationsManager.swift
//  ToDo
//
//  Created by Joe on 09/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    class func registerToDoReminderNotification(todo: ToDo) {
        
        guard let reminder = todo.reminder else { return }
        
        let components = Calendar.current.dateComponents([.minute, .hour, .day, .month, .year], from: reminder)
        let content = UNMutableNotificationContent()
        content.title = todo.title ?? Constants.EmptyString
        content.categoryIdentifier = Constants.Notification.ToDoDue
        content.body = todo.desc ?? Constants.EmptyString
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier : todo.identifier(), content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    class func removeToDoReminderNotification(todo: ToDo) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [todo.identifier()])
    }
}
