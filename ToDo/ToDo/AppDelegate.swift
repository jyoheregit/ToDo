//
//  AppDelegate.swift
//  ToDo
//
//  Created by Joe on 01/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        EventsManager.shared.requestAccessToCalendar()
        return true
    }
}

