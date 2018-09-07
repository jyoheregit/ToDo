//
//  UITableView+Extension.swift
//  ToDo
//
//  Created by Joe on 03/09/18.
//  Copyright © 2018 Jyothish. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerNibForCellClass(_ cellClass: UITableViewCell.Type) {
        let cellReuseIdentifier = cellClass.cellReuseIdentifier()
        register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
}
