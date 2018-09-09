//
//  DateTimePickerCell.swift
//  ToDo
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import UIKit
import UserNotifications
import EventKit

class DateTimePickerCell: BaseCell {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTimePickerSwitch: UISwitch!
    
    var date : Date? {
        
        didSet {
            if let date = date {
                dateTimePickerSwitch.isOn = true
                datePicker.isHidden = false
                datePicker.date = date
            }
            else {
                dateTimePickerSwitch.isOn = false
                datePicker.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setTitle(title: String) {
        headerTitle.text = title
    }
    
    override func setDateValue(date: Date?){
        self.date = date
    }
    
    @IBAction func switchToggle(_ sender: UISwitch) {
        
        if(sender.isOn){
            requestNotificationPermission()
        }
       
        datePicker.isHidden = !datePicker.isHidden
        date = datePicker.isHidden  ? nil : Date()
        dateTimeChangedBlock?(self.date)
    }
        
    private func requestNotificationPermission() {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                UserDefaults.standard.setValue(true, forKey: Constants.Notification.Enabled)
            } else {
                UserDefaults.standard.setValue(false, forKey: Constants.Notification.Enabled)
            }
        }
    }
    
   @IBAction func dateTimePickerSelected(_ sender: UIDatePicker) {
        
        date = datePicker.date
        dateTimeChangedBlock?(self.date)
    }
    
}
