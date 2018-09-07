//
//  UITableViewCell+Extension.swift
//  ToDo
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    class func cellReuseIdentifier() -> String {
        return "\(self)"
    }
}
