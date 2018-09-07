//
//  Date+Extension.swift
//  ToDo
//
//  Created by Joe on 06/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation

extension Date {
    
    func string(with format: DateFormatter) -> String {
        return format.string(from: self)
    }
    
    init?(string: String, formatter: DateFormatter) {
        guard let date = formatter.date(from: string) else { return nil }
        self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }
}
