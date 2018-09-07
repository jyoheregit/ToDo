//
//  CellType.swift
//  ToDo
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import UIKit

enum CellType {
    
    case text
    case textView
    case dateTime
    case todo
    
    func height() -> CGFloat {
        switch self {
            case .text: return 73
            case .textView: return 146
            case .dateTime: return 224
            default : return UITableViewAutomaticDimension
        }
    }
    
    func headerTitle() -> String {
        switch self {
            case .text: return "Title"
            case .textView: return "Optional Description"
            case .dateTime: return "Optional Reminder"
            default : return Constants.EmptyString
        }
    }
    
    func placeholder() -> String {
        switch self {
            case .text: return "Enter the title"
            case .textView: return "Enter the description"
            case .dateTime: return "Select the Reminder"
            default : return Constants.EmptyString
        }
    }
    
    func getClass() -> UITableViewCell.Type {
        switch self {
            case .text: return TextCell.self
            case .textView: return TextViewCell.self
            case .dateTime: return DateTimePickerCell.self
            case .todo : return ToDoCell.self
        }
    }
    
    func keyboardType() -> UIKeyboardType{
        switch self {
            default: return .default
        }
    }
}

