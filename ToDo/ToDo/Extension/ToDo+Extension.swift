//
//  ToDo+Extension.swift
//  ToDo
//
//  Created by Joe on 09/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import EventKit

extension ToDo {
    
    func createReminder() {
        
        guard UserDefaults.standard.bool(forKey: Constants.Event.ReminderAccess) == true else { return }
        
        let eventStore = EventsManager.shared.eventStore
        let reminder = EKReminder(eventStore: eventStore)
        
        if let calendar = eventStore.defaultCalendarForNewReminders() {
            reminder.calendar = calendar
            reminder.title = title
            reminder.isCompleted = completed
            reminder.notes = desc
            if let reminderDate = self.reminder{
                reminder.addAlarm(EKAlarm.init(absoluteDate: reminderDate))
            }

            do {
                try eventStore.save(reminder, commit: true)
                reminderIdentifier = reminder.calendarItemIdentifier
            } catch {
                print("Error trying to save Reminder")
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func updateReminder() {
        
        guard UserDefaults.standard.bool(forKey: Constants.Event.ReminderAccess) == true, let reminderIdentifier = reminderIdentifier else { return }
        
        let eventStore = EventsManager.shared.eventStore
        let reminder = eventStore.calendarItem(withIdentifier: reminderIdentifier)
        
        if let reminder = reminder as? EKReminder {
            reminder.title = title
            reminder.isCompleted = completed
            reminder.notes = desc
            if let reminderDate = self.reminder{
                reminder.addAlarm(EKAlarm.init(absoluteDate: reminderDate))
            }
            
            do {
                try eventStore.save(reminder, commit: true)
            } catch {
                print("Error trying to save Reminder")
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func setReminder(reminderDate : Date?){
        
        if let reminderDate = reminderDate {
            self.reminder = reminderDate
            DispatchQueue.main.async {
                NotificationManager.registerToDoReminderNotification(todo: self)
            }
        }
        else {
            self.reminder = nil
            DispatchQueue.main.async {
                NotificationManager.removeToDoReminderNotification(todo: self)
            }

        }
    }
    
    func setCompletedReminders(completed: Bool) {
        
        guard UserDefaults.standard.bool(forKey: Constants.Event.ReminderAccess) == true, let reminderIdentifier = reminderIdentifier else {return}
        
        let eventStore = EventsManager.shared.eventStore
        let reminder = eventStore.calendarItem(withIdentifier: reminderIdentifier)
        
        if let reminder = reminder as? EKReminder {
            reminder.completionDate = completed ? Date() : nil
            reminder.isCompleted = completed
            
            do {
                try eventStore.save(reminder, commit: true)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func complete(completed: Bool) {
        
        DispatchQueue.main.async {
            self.completed = completed
            if completed {
                NotificationManager.removeToDoReminderNotification(todo: self)
            } else {
                NotificationManager.registerToDoReminderNotification(todo: self)
            }
            self.setCompletedReminders(completed: completed)
        }
        
    }
    
    func delete() {
        removeFromReminders()
        NotificationManager.removeToDoReminderNotification(todo: self)
    }
    
    func removeFromReminders() {
        
        guard UserDefaults.standard.bool(forKey: Constants.Event.ReminderAccess) == true, let reminderIdentifier = reminderIdentifier  else {return}
        
        let eventStore = EventsManager.shared.eventStore
        let reminder = eventStore.calendarItem(withIdentifier: reminderIdentifier)
        
        if let reminder = reminder as? EKReminder {
            do {
                try eventStore.remove(reminder, commit: true)
            } catch {
                print("Error trying to remove a EKEvent")
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func identifier() -> String {
        return objectID.uriRepresentation().relativePath
    }
    
}
