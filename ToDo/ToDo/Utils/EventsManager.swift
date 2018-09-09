//
//  EventsManager.swift
//  ToDo
//
//  Created by Joe on 09/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import EventKit

class EventsManager
{
    static let shared = EventsManager()
    private init(){}
    lazy var eventStore = EKEventStore()
   
    func requestPermission() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.reminder)
        
        switch (status)
        {
            case EKAuthorizationStatus.notDetermined:
                requestAccessToCalendar()
            case EKAuthorizationStatus.authorized:
                print("User has access to calendar")
            case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
                print("Permission Denied or restricted")
        }
    }
    
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: .reminder, completion: { (granted, error) in
            if (granted) && (error == nil) {
                UserDefaults.standard.setValue(true, forKey: Constants.Event.ReminderAccess)
            } else {
                UserDefaults.standard.setValue(false, forKey: Constants.Event.ReminderAccess)
            }
        })
    }
}
