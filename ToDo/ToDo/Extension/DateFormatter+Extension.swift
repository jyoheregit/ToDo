//
//  DateFormatter+Extension.swift
//  ToDo
//
//  Created by Joe on 06/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let dateAndTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY HH:mm"
        return formatter
    }()
}
